<?php
	/**
	 * vt Dev Utils
	 * Copyright (C) 2012-2013  Marat Bedoev
	 *
	 * This program is free software;
	 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
	 * either version 3 of the License, or (at your option) any later version.
	 *
	 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
	 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
	 *
	 * Version:    2.0
	 * Author:     Marat Bedoev <oxid@marat.ws>
	 */

	class vtdu extends oxConfig
	{

		public function clearTmp()
		{
			$cfg = oxRegistry::get("oxConfig");
			$pattern = $cfg->getConfigParam("sCompileDir") . "*";

			$i = 0;
			$fs = 0;
			$path[] = $pattern;

			while (count($path) != 0) {
				$v = array_shift($path);
				foreach (glob($v) as $item) {
					if (is_dir($item)) {
						$path[] = $item . '/*';
					} elseif (is_file($item)) {
						$fs += filesize($item);
						unlink($item);
						$i++;
					}
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);

			return "$i files ( $fs MB )  deleted";
		}

		public function clearTpl()
		{
			$pattern = oxRegistry::get("oxConfig")->getConfigParam("sCompileDir") . "smarty/*.php";

			$i = 0;
			$fs = 0;

			foreach (glob($pattern) as $item) {
				if (is_file($item)) {
					$fs += filesize($item);
					unlink($item);
					$i++;
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);

			return "$i files ( $fs MB )  deleted";
		}

		public function clearPhp()
		{
			$pattern = oxRegistry::get("oxConfig")->getConfigParam("sCompileDir") . "oxpec_*";

			$i = 0;
			$fs = 0;

			foreach (glob($pattern) as $item) {
				if (is_file($item)) {
					$fs += filesize($item);
					unlink($item);
					$i++;
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);

			return "$i files ( $fs MB )  deleted";
		}

		public function clearLang()
		{
			oxRegistry::get("oxUtils")->resetLanguageCache();

			return "lang cache clear!";
		}


		public function getDebugSettings()
		{
			$cfg = oxRegistry::getConfig();
			$aSettings = array(
				"bShowCl"     => $cfg->getConfigParam("bShowCl"),
				"bShowTpl"    => $cfg->getConfigParam("bShowTpl"),
				"bKeepBasket" => $cfg->getConfigParam("bKeepBasket"),
			);

			return $aSettings;
		}

		public function toggleDebugSetting($sVarName)
		{
			$cfg = oxRegistry::getConfig();
			$sVarValue = (!$cfg->getConfigParam($sVarName)) ? "true" : "false";
			$cfg->saveShopConfVar("bool", $sVarName, $sVarValue, null, "module:vt-devutils");
			//$oLang = oxRegistry::getLang();
			//$string = $oLang->translateString($sVarName . "_" . $sVarValue);
			$string = "OK";

			return $string;
		}

		public function setDebugLvl()
		{
			$cfg = oxRegistry::getConfig();
			//$iDebug = intval($cfg->getRequestParameter("vtdebuglvl"));
			$iDebug = 7;

			$sCustConfig = getShopBasePath() . '/cust_config.inc.php';

			if (file_exists($sCustConfig) && is_readable($sCustConfig)) {
				include $sCustConfig;
				$sData = '$this->iDebug = ' . $iDebug . ';';
				file_put_contents($sCustConfig, $sData, FILE_APPEND | LOCK_EX);
			} else {

				$sData = '<?php $this->iDebug = ' . $iDebug . ';';
				file_put_contents($sCustConfig, $sData);
			}

			$this->cleartmp();
		}

		public function resetModuleExtends($sModuleId = null)
		{
			$cfg = oxRegistry::getConfig();
			$sModuleId = ($sModuleId === null) ? $this->getEditObjectId() : $sModuleId;

			/** @var oxModule $oModule */
			$oModule = oxNew('oxModule');
			$oModule->load($sModuleId);
			$aAddModules = $oModule->getInfo("extend");
			$sModulePath = $oModule->getModulePath();

			$aModules = $oModule->getAllModules();

			// clearing modules array
			foreach ($aModules as $sClass => $aExtends) {
				foreach ($aExtends as $key => $sExtend) {
					if (strpos($sExtend, $sModulePath) === 0)
						unset($aModules[$sClass][$key]);

				}
				if (empty($aModules[$sClass]))
					unset($aModules[$sClass]);
			}

			// merging modules array with actual data from metadata.php
			$aModules = $oModule->mergeModuleArrays($aModules, $aAddModules);
			$aModules = $oModule->buildModuleChains($aModules);

			// saving conf vars
			$cfg->setConfigParam('aModules', $aModules);
			$cfg->saveShopConfVar('aarr', 'aModules', $aModules);
		}

		public function resetModuleFiles($sModuleId = null)
		{
			$myConfig = $this->getConfig();
			$sModuleId = ($sModuleId === null) ? $this->getEditObjectId() : $sModuleId;

			$aFiles = (array)$this->getConfig()->getConfigParam('aModuleFiles');
			// deleting file records for this module if exist
			if (array_key_exists($sModuleId, $aFiles)) {
				unset($aFiles[$sModuleId]);
				$myConfig->setConfigParam('aModuleFiles', $aFiles); // saving vars
				$myConfig->saveShopConfVar('aarr', 'aModuleFiles', $aFiles);
			}
			// adding files again
			$oModule = oxnew("oxmodule");
			$oModule->load($sModuleId);
			$oModule->addModuleFiles();
		}

		public function resetModuleTemplates($sModuleId = null)
		{
			$myConfig = $this->getConfig();
			$sModuleId = ($sModuleId === null) ? $this->getEditObjectId() : $sModuleId;

			$aTemplates = (array)$this->getConfig()->getConfigParam('aModuleTemplates');
			// deleting template records for this module if exist
			if (array_key_exists($sModuleId, $aTemplates)) {
				unset($aTemplates[$sModuleId]);
				$myConfig->setConfigParam('aModuleTemplates', $aTemplates); // saving vars
				$myConfig->saveShopConfVar('aarr', 'aModuleTemplates', $aTemplates);
			}

			// adding module Blocks
			$oModule = oxnew("oxmodule");
			$oModule->load($sModuleId);
			$oModule->addModuleTemplates();
		}

		public function resetTemplateBlocks($sModuleId = null)
		{
			$myConfig = $this->getConfig();
			$oDb = oxDb::getDb();

			$sModuleId = ($sModuleId === null) ? $this->getEditObjectId() : $sModuleId;
			$sModuleQ = $oDb->quote($sModuleId);

			$sShopId = $myConfig->getShopId();
			$sShopIdQ = $oDb->quote($sShopId);

			$sQoxtplblocks = "DELETE FROM oxtplblocks WHERE oxshopid=$sShopIdQ AND oxmodule=$sModuleQ";
			//var_dump($sQoxtplblocks);
			$oDb->execute($sQoxtplblocks);

			// adding module Blocks
			$oModule = oxnew("oxmodule");
			$oModule->load($sModuleId);
			$oModule->addTemplateBlocks();
		}

		public function resetModuleSettings($sModuleId = null)
		{
			$myConfig = $this->getConfig();
			$oDb = oxDb::getDb();

			$sModuleId = ($sModuleId === null) ? $this->getEditObjectId() : $sModuleId;
			$sModuleQ = $oDb->quote("module:" . $sModuleId);

			$sShopId = $myConfig->getShopId();
			$sShopIdQ = $oDb->quote($sShopId);

			// delete all settings from oxconfig
			$sQoxconfig = "DELETE FROM oxconfig WHERE oxshopid=$sShopIdQ AND oxmodule=$sModuleQ";
			//var_dump($sQoxconfig);
			$oDb->execute($sQoxconfig);

			// delete from oxconfigdisplay
			$sQoxconfigdisplay = "DELETE FROM oxconfigdisplay WHERE OXCFGMODULE=$sModuleQ";
			//var_dump($sQoxconfigdisplay);
			$oDb->execute($sQoxconfigdisplay);

			// adding module settings
			$oModule = oxnew("oxmodule");
			$oModule->load($sModuleId);
			$oModule->addModuleSettings();
		}
	}
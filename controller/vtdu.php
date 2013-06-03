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

	class vtdu extends oxAdminDetails
	{
		public function render()
		{
			parent::render();

			if (oxRegistry::getConfig()->getRequestParameter("ajax"))
			{
				return "vtdu_ajax.tpl";
			}

			return "vtdu_frame.tpl";
		}

		public function cleartmp()
		{
			$cfg = oxRegistry::get("oxConfig");
			$pattern = $cfg->getConfigParam("sCompileDir") . "*";

			$i = 0;
			$fs = 0;
			$path[] = $pattern;

			while (count($path) != 0)
			{
				$v = array_shift($path);
				foreach (glob($v) as $item)
				{
					if (is_dir($item))
					{
						$path[] = $item . '/*';
					} elseif (is_file($item))
					{
						$fs += filesize($item);
						unlink($item);
						$i++;
					}
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);
			$this->addTplParam("content", "$i files ( $fs MB )  deleted");
		}

		public function clearsmarty()
		{
			$pattern = oxRegistry::get("oxConfig")->getConfigParam("sCompileDir") . "smarty/*.php";

			$i = 0;
			$fs = 0;

			foreach (glob($pattern) as $item)
			{
				if (is_file($item))
				{
					$fs += filesize($item);
					unlink($item);
					$i++;
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);
			$this->addTplParam("content", "$i files ( $fs MB )  deleted");
		}

		public function clearphp()
		{
			$pattern = oxRegistry::get("oxConfig")->getConfigParam("sCompileDir") . "oxpec_*";

			$i = 0;
			$fs = 0;

			foreach (glob($pattern) as $item)
			{
				if (is_file($item))
				{
					$fs += filesize($item);
					unlink($item);
					$i++;
				}
			}

			$fs = number_format($fs / 1024 / 1024, 2);
			$this->addTplParam("content", "$i files ( $fs MB )  deleted");
		}

		public function clearlang()
		{
			oxRegistry::get("oxUtils")->resetLanguageCache();
			$this->addTplParam("content", "lang cache clear!");
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

		public function toggleDebugSetting()
		{
			$cfg = oxRegistry::getConfig();
			$sVarName = $cfg->getRequestParameter("setting");
			$sVarValue = (!$cfg->getConfigParam($sVarName)) ? "true" : "false";

			$cfg->saveShopConfVar("bool", $sVarName, $sVarValue, NULL, "module:vt-devutils");
			//$oLang = oxRegistry::getLang();
			//$string = $oLang->translateString($sVarName . "_" . $sVarValue);
			$string ="OK";
			$this->addTplParam("content", $string );
		}

		public function setDebugLvl()
		{
			$cfg = oxRegistry::getConfig();
			//$iDebug = intval($cfg->getRequestParameter("vtdebuglvl"));
			$iDebug = 7;

			$sCustConfig = getShopBasePath().'/cust_config.inc.php';

			if(file_exists($sCustConfig) && is_readable($sCustConfig))
			{
				include $sCustConfig;
				$sData = '$this->iDebug = '.$iDebug.';';
				file_put_contents($sCustConfig, $sData, FILE_APPEND | LOCK_EX);
			}
			else
			{

				$sData = '<?php $this->iDebug = '.$iDebug.';';
				file_put_contents($sCustConfig,$sData);
			}

			$this->cleartmp();
		}
	}
<?php

class vtdu extends oxAdminView
{
	public function render()
	{
		parent::render();

		if(oxRegistry::getConfig()->getRequestParameter("ajax")) { return "vtdu_ajax.tpl"; }
		return "vtdu_frame.tpl";
	}

	public function cleartmp()
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
		$this->_aViewData['content'] = "$i files ( $fs MB )  deleted";
	}

	public function clearsmarty()
	{
		$cfg = oxRegistry::get("oxConfig");
		$pattern = $cfg->getConfigParam("sCompileDir") . "smarty/*";

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
		$this->_aViewData['content'] = "$i files ( $fs MB )  deleted";
	}

	public function clearphp()
	{
		$cfg = oxRegistry::get("oxConfig");
		$pattern = $cfg->getConfigParam("sCompileDir") . "oxpec_*";

		$i = 0;
		$fs = 0;

		foreach (glob($pattern) as $item) {
			if (is_file($item))
			{
				$fs += filesize($item);
				unlink($item);
				$i++;
			}
		}

		$fs = number_format($fs / 1024 / 1024, 2);
		$this->_aViewData['content'] = "$i files ( $fs MB )  deleted";
	}

	public function clearlang()
	{
		$cfg = oxRegistry::get("oxConfig");
		$pattern = $cfg->getConfigParam("sCompileDir") . "oxpec_langcache_*";

		foreach (glob($pattern) as $item) {
			if (is_file($item)) {
				unlink($item);
			}
		}

		$this->_aViewData['content'] = "lang cache clear!";
	}

	public function clearconfig()
	{
		$cfg = oxRegistry::get("oxConfig");
		$pattern = $cfg->getConfigParam("sCompileDir") . "config*";

		foreach (glob($pattern) as $item) {
			if (!is_dir($item)) {
				unlink($item);
			}
		}

		$this->_aViewData['content'] = "config cache clear!";
	}

	public function getDebugSettings()
	{
		$cfg = oxRegistry::getConfig();
		$aSettings = array(
			"bShowCl" => $cfg->getConfigParam("bShowCl"),
			"bShowTpl" => $cfg->getConfigParam("bShowTpl"),
			"bKeepBasket" => $cfg->getConfigParam("bKeepBasket"),
		);

		return $aSettings;
	}

	public function toggleDebugSetting()
	{
		$cfg = oxRegistry::getConfig();
		$sVarName = $cfg->getRequestParameter("setting");
		$sVarValue = (!$cfg->getConfigParam($sVarName)) ? "true":"false";
		
		$cfg->saveShopConfVar("bool", $sVarName, $sVarValue, null, "module:vt-devutils");
		$oLang = oxRegistry::getLang();
		$string = $oLang->translateString($sVarName."_".$sVarValue);
		
		$this->_aViewData['content'] = $string;

		//$sVarvalue = $cfg->getRequestParameter("varvalue");
	}
	
	public function setDebugLvl()
	{
		$cfg = oxRegistry::getConfig();
		$iDebug = intval($cfg->getRequestParameter("vtdebuglvl"));
		$cfg->setConfigParam("iDebug", $iDebug);
		$this->clearsmarty();
	}
}
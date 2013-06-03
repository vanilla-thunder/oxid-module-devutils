<?php

	class vtdu_be extends oxAdminView
	{
		public function render()
		{
			parent::render();
			if (oxRegistry::getConfig()->getRequestParameter("ajax"))
			{
				return "vtdu_ajax.tpl";
			}
			return "vtdu_be.tpl";
		}

		public function getDebugSettings()
		{
			$vtdu = oxRegistry::get("vtdu");
			return $vtdu->getDebugSettings();
		}


		public function clearTmp()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearTmp() );
		}

		public function clearTpl()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearTpl() );
		}

		public function clearPhp()
		{
			$vtdu = oxRegistry::get("vtdu");
			$this->addTplParam("content", $vtdu->clearPhp() );
		}

		public function clearLang()
		{
			oxRegistry::get("oxUtils")->resetLanguageCache();
			$this->addTplParam("content", "lang cache clear!");
		}

		public function toggleDebugSetting()
		{
			$cfg = oxRegistry::getConfig();
			$vtdu = oxRegistry::get("vtdu");
			$sVarName = $cfg->getRequestParameter("setting");
			$this->addTplParam("content", $vtdu->toggleDebugSetting($sVarName) );
		}

		public function setDebugLvl()
		{
			$cfg = oxRegistry::getConfig();
			//$iDebug = intval($cfg->getRequestParameter("vtdebuglvl"));
			$iDebug = 7;

			$sCustConfig = getShopBasePath() . '/cust_config.inc.php';

			if (file_exists($sCustConfig) && is_readable($sCustConfig))
			{
				include $sCustConfig;
				$sData = '$this->iDebug = ' . $iDebug . ';';
				file_put_contents($sCustConfig, $sData, FILE_APPEND | LOCK_EX);
			} else
			{

				$sData = '<?php $this->iDebug = ' . $iDebug . ';';
				file_put_contents($sCustConfig, $sData);
			}

			$this->cleartmp();
		}
	}
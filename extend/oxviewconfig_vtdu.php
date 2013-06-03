<?php

	class oxviewconfig_vtdu extends oxviewconfig_vtdu_parent
	{

		public function getConfig()
		{
			return oxRegistry::getConfig();
		}

		public function getVTdebugSetting($sSetting = NULL)
		{
			switch ($sSetting)
			{
				case "bShowCl":
					return oxRegistry::getConfig()->getConfigParam("bShowCl");
					break;
				case "bShowTpl":
					return oxRegistry::getConfig()->getConfigParam("bShowTpl");
					break;
				case "bKeepBasket":
					return oxRegistry::getConfig()->getConfigParam("bKeepBasket");
					break;
			}

			return false;
		}
	}

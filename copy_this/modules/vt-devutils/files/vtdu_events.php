<?php

	class vtdu_events extends oxConfig
	{

		public static function activate()
        {
            $vtdu = oxNew("vtdu");
            $vtdu->clearTmp();
			$vtdu->resetModuleFiles("vt-devutils");
			$vtdu->resetModuleExtends("vt-devutils");
			$vtdu->resetModuleTemplates("vt-devutils");
			$vtdu->resetTemplateBlocks("vt-devutils");
			$vtdu->resetModuleSettings("vt-devutils");
			$vtdu->clearTmp();
			oxRegistry::getConfig()->getActiveView()->addTplParam("updatenav", "1");
        }
	}
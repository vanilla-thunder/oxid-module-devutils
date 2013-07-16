<?php

	class module_main_vtdu extends module_main_vtdu_parent
	{

		public function resetModuleSettings()
		{
			$sModuleId = $this->getEditObjectId();
			oxRegistry::get("vtdu")->resetModuleSettings($sModuleId);

			$this->_aViewData["message"] = "module settings for $sModuleId were resetted";
		}

		public function resetModuleExtends()
		{
			$sModuleId = $this->getEditObjectId();
			oxRegistry::get("vtdu")->resetModuleExtends($sModuleId);

			$this->_aViewData["message"] = "class extensions for $sModuleId were resetted";
		}

		public function resetModuleFiles()
		{
			$sModuleId = $this->getEditObjectId();
			oxRegistry::get("vtdu")->resetModuleFiles($sModuleId);

			$this->_aViewData["message"] = "module files for $sModuleId were resetted";
		}

		public function resetModuleTemplates()
		{
			$sModuleId = $this->getEditObjectId();
			oxRegistry::get("vtdu")->resetModuleTemplates($sModuleId);

			$this->_aViewData["message"] = "module templates for $sModuleId were resetted";
		}

		public function resetTemplateBlocks()
		{
			$sModuleId = $this->getEditObjectId();
			oxRegistry::get("vtdu")->resetTemplateBlocks($sModuleId);

			$this->_aViewData["message"] = "template blocks for $sModuleId were resetted";
		}

	}
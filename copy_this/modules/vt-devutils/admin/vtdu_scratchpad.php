<?php

class vtdu_scratchpad extends oxAdminView {

	protected $_tpl = 'vtdu_scratchpad.tpl';

	public function render() {
		
		
		
		parent::render();
		return $this->_tpl;
	}

	public function doTest() {
		
		$cfg = oxRegistry::get("oxConfig");
		$code = $cfg->getParameter("codeinput");
		$this->_aViewData["codeinput"] = $code;
		
		ob_start();
		
		
		
		//echo "$code";
		$ex = eval($code);
	
		//$encoder = oxRegistry::get("oxSeoEncoder");
		
		$this->_aViewData["codeoutput"] = ob_get_contents();
		$this->_aViewData["codeerror"] = $ex;
		ob_end_clean();
	}

}
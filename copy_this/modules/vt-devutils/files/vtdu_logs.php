<?php

	class vtdu_logs extends oxAdminView
	{

		protected $_tpl = 'vtdu_logs.tpl';
		protected $_sExLog = null;
		protected $_sSrvErrLog = null;
		protected $_sSqlLog = null;
		protected $_sMailsLog = null;


	public function init()
	{
		parent::init();
		$cfg = oxRegistry::getConfig();
		$this->_sExLog     = ( $cfg->getConfigParam('bExLog'))     ? $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt' : false;

		$this->_sSrvErrLog = ( $cfg->getConfigParam('bSrvErrLog')) ? $cfg->getConfigParam('sSrvErrLog') : false;
		if(substr($this->_sSrvErrLog, 0,1) !== "/") $this->_sSrvErrLog = $cfg->getConfigParam('sShopDir') . $this->_sSrvErrLog; // relative path?

		$this->_sSqlLog    = ( $cfg->getConfigParam('bSqlLog')   ) ? $cfg->getConfigParam('sSqlLog')    : false;

		$this->_sMailsLog  = ( $cfg->getConfigParam('bMailLog')  ) ? $cfg->getConfigParam('sMailLog')   : false;
	}
		public function render()
		{
			parent::render();
			$cfg = oxRegistry::getConfig();



			$this->_aViewData['ExLog']     = ($this->_sExLog) ? $this->getExceptionLog() : false;;
			$this->_aViewData['SrvErrLog'] = $this->getErrorLog();
			$this->_aViewData['SqlLog']    = false;
			$this->_aViewData['MailLog']   = false;

			//var_dump("<h2>".$this->_sExLogPath."</h2>");
			//$this->getExceptionLog();
			//echo "<hr/>";
			//var_dump("<h2>".$this->_sErrorLog."</h2>");
			//$this->_aViewData['ErrorLog'] = $this->getErrorLog();
			//echo "<hr/>";
			//var_dump("<h2>".$this->_sDbLog."</h2>");
			//echo "<hr/>";
			//var_dump("<h2>".$this->_sMailLog."</h2>");
			//$this->_aViewData['ExceltionLog'] = "logs";


			return $this->_tpl;
		}

		public function getExceptionLog()
		{
			if (!$this->_sExLog)
				return false;

			$cfg = oxRegistry::getConfig();

			if ( !file_exists($this->_sExLog) || !is_readable($this->_sExLog) )
				return array( (object) array( "header" => "ERROR: file does not exist od is not readable", "text" => "perhaps you had no exceptions yet?") );

			$iExLog = intval($cfg->getConfigParam("iExLog"));
			$iExLog = $iExLog ? $iExLog : 10;

			$sData = file_get_contents($this->_sExLog);
			$aData = explode("---------------------------------------------", $sData);
			$aData = array_slice($aData, -($iExLog+1));
			array_pop($aData); // cut last empty array element

			array_walk($aData, array($this, '_prepareExLog'));

			return ($aData) ? $aData : array( (object) array("header" => "exception log is empty", "text" => "don't worry, be happy!") );
		}
		private function _prepareExLog(&$item, $key)
		{
			$aEx = explode("Stack Trace:",trim($item));
			$item = (object) array(
				"header" => str_replace("[0]:","<br/><small>",$aEx[0])."</small>",
				"text" => htmlentities(trim($aEx[1]))
			);
		}
		public function restartExceptionLog()
		{
			$oldname = basename($this->_sExLog);
			$newname = substr($oldname, 0,-4)."_".date("Y-m-d").substr($oldname,-4);

			$backup = file_get_contents($this->_sExLog);

			if(empty($backup))
			{
				$this->addTplParam("exLogEmpty",true);
				return;
			}

			file_put_contents(str_replace($oldname, $newname, $this->_sExLog), $backup, FILE_APPEND); // backup actual content
			file_put_contents($this->_sExLog, ''); // create new log file

			$this->addTplParam("exLogRestart",$newname);
		}


		public function getErrorLog()
		{
			if (!$this->_sSrvErrLog)   return false;

			$cfg = oxRegistry::getConfig();

			if ( !file_exists($this->_sSrvErrLog) || !is_readable($this->_sSrvErrLog) )
				return array( "ERROR: file does not exist od is not readable", "please check the path set in module settings");

			$iSrvErrLog = intval($cfg->getConfigParam("iSrvErrLog"));
			$iSrvErrLog = $iSrvErrLog ? $iSrvErrLog : 10;

			$aData = file($this->_sSrvErrLog);
			$aData = array_slice($aData, -$iSrvErrLog);

			array_walk($aData, array($this, '_prepareSrvErrLog'));

			return ($aData) ? $aData : array( (object) array("date" => "", "type" => "", "client" => "", "text" => "webserver error log is empty") );
		}
		private function _prepareSrvErrLog(&$item, $key)
		{
			//$aEx = preg_split ("(\[client [\d\.]+\])",$item);
			//$aEx = preg_split ("(\sin\s)",$item);
			$aLog = explode("] ", $item, 4);
			//preg_match("([a-zA-Z0-9\s\.\:]+)", $item, $date);
			$aSearch = array(" in ", " referer:");
			$aReplace = array("<br/>in ", "<br/>referer:<small>");
			$aEx = array(
				"date"   => trim(substr($aLog[0],1)),
				"type"   => trim(substr($aLog[1],1)),
				"client" => trim(substr($aLog[2],1)),
				"text"   => str_replace($aSearch, $aReplace, trim($aLog[3]))."</small>"
			);

			$item = (object) $aEx;
		}
		public function restartSrvErrLog()
		{
			if(!$this->_sSrvErrLog) return false;

			$backup = file($this->_sSrvErrLog);

			if(empty($backup))
			{
				$this->addTplParam("srvErrLogEmpty",true);
				return;
			}

			file_put_contents($this->_sSrvErrLog."_".date("Y-m-d"), $backup, FILE_APPEND); // backup actual content
			file_put_contents($this->_sSrvErrLog, ''); // create new log file

			$this->addTplParam("srvErrLogRestart",basename($this->_sSrvErrLog)."_".date("Y-m-d"));
		}
	}
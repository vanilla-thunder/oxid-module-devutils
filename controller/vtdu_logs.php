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
		$this->_sExLog     = ( $cfg->getConfigParam('bSrvErrLog')) ? $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt'            : false;
		$this->_sSrvErrLog = ( $cfg->getConfigParam('bSrvErrLog')) ? $cfg->getConfigParam('sSrvErrLog') : false;
		$this->_sSqlLog    = ( $cfg->getConfigParam('bSqlLog')   ) ? $cfg->getConfigParam('sSqlLog')    : false;
		$this->_sMailsLog  = ( $cfg->getConfigParam('bMailLog')  ) ? $cfg->getConfigParam('sMailLog')   : false;
	}
		public function render()
		{
			parent::render();
			$cfg = oxRegistry::getConfig();



			$this->_aViewData['ExLog']     = $this->getExceptionLog();
			$this->_aViewData['SrvErrLog'] = $this->getErrorLog();
			$this->_aViewData['SqlLog']    = "ok";
			$this->_aViewData['MailLog']   = "ok";

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
			if (!$this->_sSrvErrLog)
				return false;

			$cfg = oxRegistry::getConfig();

			if ( !file_exists($this->_sExLog) || !is_readable($this->_sExLog) )
				return array( (object) array( "header" => "ERROR: file does not exist od is not readable", "text" => "perhaps you had no exceptions yet?") );

			$iExLog = intval($cfg->getConfigParam("iExLog"));
			$iExLog = $iExLog ? $iExLog : 10;

			$sData = file_get_contents($this->_sExLog);
			$aData = explode("---------------------------------------------", $sData);
			$aData = array_slice($aData, -$iExLog-1, $iExLog);

			array_walk($aData, array($this, '_prepareExLog'));

			return $aData;
		}
		private function _prepareExLog(&$item, $key)
		{
			$aEx = explode("Stack Trace:",trim($item));
			$item = (object) array(
				"header" => str_replace("[0]:","<br/><small>",$aEx[0])."</small>",
				"text" => trim($aEx[1])
			);
		}

		public function getErrorLog()
		{
			if (!$this->_sSrvErrLog)
				return false;

			$cfg = oxRegistry::getConfig();

			// relative path?
			if(substr($this->_sSrvErrLog, 0,1) != "/")
				$this->_sSrvErrLog = $cfg->getConfigParam('sShopDir') . $this->_sSrvErrLog;

			if ( !file_exists($this->_sSrvErrLog) || !is_readable($this->_sSrvErrLog) )
				return array( "ERROR: file does not exist od is not readable", "please check the path set in module settings");

			$iSrvErrLog = intval($cfg->getConfigParam("iSrvErrLog"));
			$iSrvErrLog = $iSrvErrLog ? $iSrvErrLog : 10;

			$aData = file($this->_sSrvErrLog);
			$aData = array_slice($aData, -$iSrvErrLog);

			array_walk($aData, array($this, '_prepareSrvErrLog'));

			return $aData;

			$aParsedLog = array();
			$x = 0;
			foreach ($aErrorLog as $row)
			{
				/*
					 $dateA = strpos($row,"[")+1;
					 $dateB = strpos($row,"]");
					 $aParsedLog[$x][] = substr($row, $dateA, $dateB-$dateA);

					 $typeA = strpos($row,"[", $dateA)+1;
					 $typeB = strpos($row,"]", $typeA);
					 $aParsedLog[$x][] = substr($row, $typeA, $typeB-$typeA);

					 $errTypeA = strpos($row,"]", $typeB+1)+1;
					 $errTypeB = strpos($row,":", $errTypeA);
					 $aParsedLog[$x][] = substr($row, $errTypeA, $errTypeB-$errTypeA);

					 //$msgA = strpos($row,"]", $errTypeB+1)+1;
					 $msgB = strpos($row,", referer");
					 $aParsedLog[$x][] = trim(substr($row, $errTypeB+1, $msgB-$errTypeB-1));

					 $aParsedLog[$x][] = $row;
					 $x++;
					*/
				/*
			  $regex = '/^\[([^\]]+)\] \[([^\]]+)\] (?:\[client ([^\]]+)\])?\s*(.*)$/i';
			  $matches = Array();
			  preg_match($regex, $aErrorLog, $matches);

			  $date = $matches[1]; //Date and time
			  $severity = $matches[2]; // severity
			  $client = $matches[3]; // client addr (if present)
			  $msg = $matches[4]; // log message

			  $aParsedLog[$date][] = $severity;
			  $aParsedLog[$date][] = $client;
			  $aParsedLog[$date][] = $msg;
			}
			return $aParsedLog;


			echo"<pre>";
			for ($i = count($aErrorLog) - 10; $i < count($aErrorLog); $i++) {
			  echo $aErrorLog[$i];
			}
			echo "</pre>";
		  */
			}

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
	}
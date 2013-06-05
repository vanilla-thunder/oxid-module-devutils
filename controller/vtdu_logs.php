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
		$this->_sExLog = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';
		$this->_sSrvErrLog = ( $cfg->getConfigParam('bSrvErrLog')) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sSrvErrLog') : false;
		$this->_sSqlLog    = ( $cfg->getConfigParam('bSqlLog')   ) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sSqlLog')    : false;
		$this->_sMailsLog  = ( $cfg->getConfigParam('bMailLog')  ) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sMailLog')   : false;
	}
		public function render()
		{
			parent::render();
			$cfg = oxRegistry::getConfig();



			$this->_aViewData['ExLog']     = $this->getExceptionLog();
			$this->_aViewData['SrvErrLog'] = "ok";
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
			$cfg = oxRegistry::getConfig();
			if ( !file_exists($this->_sExLog) || !is_readable($this->_sExLog) )
			{
				return "ERROR: file does not exist od is not readable";
			}

			$sData = file_get_contents($this->_sExLog);
			$aData = explode("---------------------------------------------", $sData);
			$aData = array_slice($aData, -10, 10);

			return array("ok1","ok2",count($aData));
		}

		public function getErrorLog()
		{
			if (!$this->_sErrorLog)
				return false;

			$aErrorLog = file($this->_sErrorLog);

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
	}
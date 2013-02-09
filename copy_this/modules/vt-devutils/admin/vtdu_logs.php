<?php

class vtdu_logs extends oxAdminView {

  protected $_tpl = 'vtdu_logs.tpl';
  protected $_sExLogPath;
  protected $_sErrorLog;
  protected $_sDbLog;
  protected $_sMailsLog;

  public function init() {
	parent::init();
	$cfg = $this->getConfig();
	$this->_sExLogPath = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';
	$this->_sErrorLog = ( $cfg->getConfigParam('bErrLog') ) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sErrLog') : false;
	$this->_sDbLog = ( $cfg->getConfigParam('bDbLog') ) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sDbLog') : false;
	$this->_sMailsLog = ( $cfg->getConfigParam('bMailLog') ) ? $cfg->getConfigParam('sShopDir') . $cfg->getConfigParam('sMailLog') : false;
  }

  public function render() {
	parent::render();
	$cfg = $this->getConfig();


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

  public function getExceptionLog() {
	$cfg = $this->getConfig();


	$mdaExs = array();
	$arrX = 0;
	foreach (file($this->_sExLogPath) as $line) {
	  if (strpos($line, "--------------------------------------------") !== false) {
		$arrX++;
	  } elseif (strlen(trim($line)) != 0) {
		$mdaExs[$arrX][] = trim($line);
	  }
	}

	/* echo"<pre>";
	  foreach ($mdaExs as $aEx) {
	  $xTime = strpos($aEx[0], "(time:") + 7;
	  $yTime = strpos($aEx[0], "): [0]");
	  echo "<p><strong>$xTime -> $yTime</strong></br>";
	  echo substr($aEx[0], $xTime, $yTime - $xTime) . " " . substr($aEx[0], $yTime + 7) . "<br/>" . end($aEx) . "<br/>";
	  // getting filename
	  $sExFile = substr($aEx[2], 3, strpos($aEx[2], "(") - 3);
	  $iExRow = substr($aEx[2], strpos($aEx[2], "(") + 1, strpos($aEx[2], ")") - strpos($aEx[2], "(") - 1);
	  echo "Datei: $sExFile<br/>";
	  echo "Zeile: $iExRow<br/>";
	  $aExFile = file($sExFile);
	  echo "<pre>";
	  echo ($iExRow - 3) . "   " . $aExFile[$iExRow - 3];
	  echo ($iExRow - 2) . "   " . $aExFile[$iExRow - 2];
	  echo ($iExRow - 1) . "   <strong style='color:red;'>" . $aExFile[$iExRow - 1] . "</strong>";
	  echo ($iExRow) . "   " . $aExFile[$iExRow];
	  echo ($iExRow + 1) . "   " . $aExFile[$iExRow + 1];
	  echo"</pre>";
	  echo"</p><hr/>";
	  }
	  //var_dump($aContent);
	  echo"</pre>"; */
  }

  public function getErrorLog() {
	if (!$this->_sErrorLog)
	  return false;

	$aErrorLog = file($this->_sErrorLog);
	
	$aParsedLog = array();
	$x = 0;
	foreach ($aErrorLog as $row) {
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
	}
	return $aParsedLog;
	
	echo"<pre>";
	for ($i = count($aErrorLog) - 10; $i < count($aErrorLog); $i++) {
	  echo $aErrorLog[$i];
	}
	echo "</pre>";
  }

}
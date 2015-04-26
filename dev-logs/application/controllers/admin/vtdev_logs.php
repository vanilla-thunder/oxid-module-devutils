<?php

/**
 * vt dev utilities - logs
 * The MIT License (MIT)
 *
 * Copyright (C) 2015  Marat Bedoev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Version:    0.9
 * Author:     Marat Bedoev <oxid@marat.ws>
 */
class vtdev_logs extends oxAdminView
{

    protected $_sThisTemplate  = 'vt_dev_logs.tpl';

    protected $_sExLog = null;
    protected $_sErrLog = null;
    //protected $_sSqlLog = null;
    //protected $_sMailsLog = null;


    public function init()
    {
        parent::init();

        $cfg = oxRegistry::getConfig();

        $this->_sExLog  = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';
        $this->_sErrLog = ($cfg->getConfigParam('vt_dev_logs_sWebserverLog')) ? $cfg->getConfigParam('vt_dev_logs_sWebserverLog') : false;
        //$this->_sSqlLog = ($cfg->getConfigParam('bSqlLog')) ? $cfg->getConfigParam('sSqlLog') : false;
        //$this->_sMailsLog = ($cfg->getConfigParam('bMailLog')) ? $cfg->getConfigParam('sMailLog') : false;

        if (substr($this->_sErrLog, 0, 1) !== "/") $this->_sErrLog = $cfg->getConfigParam('sShopDir') . $this->_sErrLog; // relative path for webserver error log?
    }

    public function render()
    {
        $cfg = oxRegistry::getConfig();

        $this->addTplParam('exLog', $this->getExceptionLog());
        //$this->addTplParam('errLog', $this->getErrorLog());
        $this->addTplParam('SqlLog', false);
        $this->addTplParam('MailLog', false);

        //var_dump("<h2>".$this->_sExLogPath."</h2>");
        //$this->getExceptionLog();
        //echo "<hr/>";
        //var_dump("<h2>".$this->_sErrorLog."</h2>");
        //$this->addTplParam('ErrorLog'] = $this->getErrorLog();
        //echo "<hr/>";
        //var_dump("<h2>".$this->_sDbLog."</h2>");
        //echo "<hr/>";
        //var_dump("<h2>".$this->_sMailLog."</h2>");
        //$this->addTplParam('ExceltionLog'] = "logs";


        return parent::render();
    }

    public function getExceptionLog()
    {
        $cfg = oxRegistry::getConfig();
        $sExLog = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';

        if (!file_exists($this->_sExLog) || !is_readable($this->_sExLog))
        {
            $this->addTplParam("error", (object)array("type" => "warning", "text" => "EXCEPTION_LOG.txt does not exist or is not readable"));
            return false;
        }

        if ($sData = file_get_contents($this->_sExLog))
        {
            $aData = explode("---------------------------------------------", $sData);
            $aData = array_slice($aData, -11);
            array_pop($aData); // cut last empty array element
            foreach($aData as $key => $value)
            {
                $aEx = explode("Stack Trace:", trim($value));
                $aData[$key] = (object)array(
                    "header" => str_replace("[0]:", "<br/><b>", $aEx[0]) . "</b>",
                    "text" => htmlentities(str_replace($cfg->getConfigParam("sShopDir"),"",trim($aEx[1])))
                );
            }

            return array_reverse($aData);
        }

        return false;
    }

    public function clearExceptionLog()
    {
        file_put_contents($this->_sExLog, '');
    }

    public function backupExceptionLog()
    {
        $oldname = $this->_sExLog;
        $newname = str_replace(".txt", "_".date("Y-m-d").".txt", $oldname);

        rename($oldname,$newname);

        //file_put_contents(str_replace($oldname, $newname, $this->_sExLog), file_get_contents($this->_sExLog), FILE_APPEND); // backup actual content
        //$this->clearExceptionLog();
    }


    public function getWebserverErrorLog()
    {
        if (!$this->_sErrLog) return false;
        if (!file_exists($this->_sErrLog) || !is_readable($this->_sErrLog))
        {
            $this->addTplParam("error", (object)array("type" => "warning", "text" => "file does not exist or is not readable"));
            return false;
        }

        $aData = file($this->_sErrLog);
        $aData = array_slice($aData, -10);
        array_walk($aData, array($this, '_prepareWebserverErrLog'));

        echo json_encode(array_reverse($aData));
        exit;
    }

    private function _prepareWebserverErrLog(&$item, $key)
    {
        //echo print_r($item, true)."\n<hr/>";
        preg_match_all("(\[[^\]]+\])",$item, $header);
        $header = $header[0];

        $conetnt = preg_split("/,/",trim(str_replace($header,'',$item)));

        $aEx = array(
            "date" => $header[0],
            "type" => $header[1],
            "client" => $header[2],
            "header" => array_shift($conetnt),
            "text" => implode("\n",$conetnt)
        );

        $item = (object)$aEx;
    }

    public function isErrorLogWritable()
    {
        return ($this->_sErrLog && file_exists($this->_sErrLog) && is_writable($this->_sErrLog)) ? true : false;
    }

    public function clearErrorLog()
    {
        if( $this->isErrorLogWritable() ) file_put_contents($this->_sErrLog, '');
    }



}
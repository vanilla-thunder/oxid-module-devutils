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

    protected $_aModuleComponents = false;
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

        //$this->addTplParam('exLog', $this->getExceptionLog());
        $this->addTplParam('errlog', $this->_sErrLog);
        $this->addTplParam('ip', $_SERVER['REMOTE_ADDR']);
        
        $this->addTplParam("module_components", ($this->_aModuleComponents ? ",".$this->_aModuleComponents : ''));

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

        if (!file_exists($sExLog) || !is_readable($sExLog))
        {
            header('HTTP/1.1 500 Error reading ');
            header('Content-Type: application/json; charset=UTF-8');
            die(json_encode(array('error' => "EXCEPTION_LOG.txt does not exist or is not readable")));
        }

        if ($sData = file_get_contents($sExLog))
        {
            $aData = explode("---------------------------------------------", $sData);
            $aData = array_slice($aData, -101);
            array_pop($aData); // cut last empty array element
            foreach($aData as $key => $value)
            {
                $aEx = explode("Stack Trace:", trim($value));
                $aHeader = explode("[0]:",$aEx[0]);
                $aData[$key] = (object)array(
                    "header" => str_replace($cfg->getConfigParam("sShopDir"),"",trim($aHeader[0])),
                    "subheader" => str_replace($cfg->getConfigParam("sShopDir"),"",trim($aHeader[1])),
                    "text" => htmlentities(str_replace($cfg->getConfigParam("sShopDir"),"",trim($aEx[1]))),
                    "full" => $value
                );
            }
            
            $time = filemtime($sExLog);
            echo json_encode(array_reverse($aData));
            exit;
        }

            header('HTTP/1.1 500 Error reading ');
            header('Content-Type: application/json; charset=UTF-8');
            die(json_encode(array('error' => "something went wrong")));
    }


    public function getErrorLog()
    {
        if (!$this->_sErrLog) return false;
        
        $cfg = oxRegistry::getConfig();
        if (!file_exists($this->_sErrLog) || !is_readable($this->_sErrLog))
        {
            $this->addTplParam("error", (object)array("type" => "warning", "text" => "file does not exist or is not readable"));
            return false;
        }

        $aData = file($this->_sErrLog);
        $aData = array_slice($aData, -100);

        foreach($aData as $key => $value)
        {
            /*
            [Sat May 30 10:32:38 2015] [error] [client 79.222.227.99] 
            PHP Fatal error:  Smarty error: [in vt_dev_footer.tpl line 7]: syntax error: unrecognized tag: $module_components:default:"'lumx'" (Smarty_Compiler.class.php, line 446) in /srv/ox/bla/core/smarty/Smarty.class.php on line 1093, referer: http://ox.marat.ws/bla/admin/index.php?editlanguage=0&force_admin_sid=5fdleoj00epaoe5d75d5hi6q01&stoken=C8D0F139&&cl=navigation&item=home.tpl
            */
            preg_match_all("/\[([^\]]*)\]/",$value, $header);
            $msg = trim(str_replace(array_slice($header[0],0,3),'',$value));

            // in: between " in" and " referer"
            preg_match("/\sin\s\/(.*)\sreferer\:/",$msg, $in);
            
            // referer: after "referer"
            preg_match("/\sreferer\:(.*)/",$msg, $in);
            

            $aErr = array(
                "type" => $header[1][1],
                "date" => $header[1][0],
                "header" => substr($msg, 0, strpos($msg, " in /")),
                "in" => str_replace($cfg->getConfigParam("sShopDir"),"","/".$in[1]),
                //"in" => substr($msg, strpos($msg, " in /")+3, strpos($msg, ", referer: ")),
                "referer" => substr($msg, strpos($msg, ", referer: ")+10),
                "client" => $header[1][2]
            );
            $aData[$key] = (object) $aErr;
            
            // "in" => str_replace($cfg->getConfigParam("sShopDir"),"",substr($msg, strpos($msg, " in /")+3, strpos($msg, ", referer: "))),
        }

        echo json_encode(array_reverse($aData));
        exit;
    }

}
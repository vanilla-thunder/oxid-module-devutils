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
    protected $_sThisTemplate = 'vt_dev_logs.tpl';

    protected $_sExLog = null;
    protected $_sErrLog = null;
    //protected $_sSqlLog = null;
    //protected $_sMailsLog = null;

    public function init()
    {
        parent::init();

        $cfg = oxRegistry::getConfig();

        $this->_sExLog  = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';
        $this->_sErrLog = ($cfg->getConfigParam('s_vtDev_serverLogPath')) ? $cfg->getConfigParam('s_vtDev_serverLogPath') : false;
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
        $cfg    = oxRegistry::getConfig();
        $sExLog = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';

        if (!file_exists($sExLog) || !is_readable($sExLog)) die(json_encode(['status' => "EXCEPTION_LOG.txt does not exist or is not readable"]));

        $sData = file_get_contents($sExLog);

        $aData = explode("---------------------------------------------", $sData);
        $aData = array_slice($aData, -101);
        array_pop($aData); // cut last empty array element
        foreach ($aData as $key => $value) {
            $aEx     = explode("Stack Trace:", trim($value));
            $aHeader = explode("[0]:", $aEx[0]);

            $iFC = preg_match("/Faulty\scomponent\s\-\-\>\s(.*)/", $aEx[1], $aFC);

            $aData[$key] = (object)array(
                "header" => str_replace($cfg->getConfigParam("sShopDir"), "", trim($aHeader[0])),
                "subheader" => str_replace($cfg->getConfigParam("sShopDir"), "", trim($aHeader[1])) . ($iFC == 1 ? ": " . $aFC[1] : ""),
                "text" => htmlentities(str_replace($cfg->getConfigParam("sShopDir"), "", trim($aEx[1]))),
                "full" => $value
            );
        }

        //$time = filemtime($sExLog);
        die(json_encode(['status' => 'ok', 'log' => array_reverse($aData)]));
    }

    public function getErrorLog()
    {
        if (!$this->_sErrLog) return false;

        $cfg = oxRegistry::getConfig();
        if (!file_exists($this->_sErrLog) || !is_readable($this->_sErrLog)) die(json_encode(['status' => "file does not exist or is not readable"]));

        $aData = file($this->_sErrLog);

        // xdebug?
        if (function_exists('xdebug_get_code_coverage')) $this->_getXdebugErrorLog($aData);

        $aData = array_slice($aData, -300);
//echo "<pre>";
        foreach ($aData as $key => $value) {
            /*
            [Sat May 30 10:32:38 2015] [error] [client 79.222.227.99] 
            PHP Fatal error:  Smarty error: [in vt_dev_footer.tpl line 7]: syntax error: unrecognized tag: $module_components:default:"'lumx'" (Smarty_Compiler.class.php, line 446) in /srv/ox/bla/core/smarty/Smarty.class.php on line 1093, referer: http://ox.marat.ws/bla/admin/index.php?editlanguage=0&force_admin_sid=5fdleoj00epaoe5d75d5hi6q01&stoken=C8D0F139&&cl=navigation&item=home.tpl
            */
/*
            print_r($key);
            print_r($value);
            echo "<hr/>";
            */

            preg_match_all("/\[([^\]]*)\]/", $value, $header);
            $msg = trim(str_replace(array_slice($header[0], 0, 3), '', $value));

            // in: between " in" and " referer"
            preg_match("/\sin\s\/(.*)\sreferer\:/", $msg, $in);

            // referer: after "referer"
            preg_match("/\sreferer\:(.*)/", $msg, $ref);

            $replace = [$ref[0], ' in /' . $in[1]];

            $aErr        = array(
                "date" => date_format(date_create($header[1][0]), 'Y-m-d H:i:s'),
                "type" => $header[1][1],
                "client" => $header[1][2],
                "header" => str_replace($replace, "", $msg),
                "in" => str_replace($cfg->getConfigParam("sShopDir"), "", "/" . $in[1]),
                "referer" => $ref[1],
                "full" => $value

            );
            $aData[$key] = (object)$aErr;

            // "in" => str_replace($cfg->getConfigParam("sShopDir"),"",substr($msg, strpos($msg, " in /")+3, strpos($msg, ", referer: "))),
        }
        //echo "<pre>";
        echo json_encode(['status' => 'ok', 'log' => array_reverse($aData)]);
        exit;
    }

    protected function _getXdebugErrorLog($aData)
    {
        $cfg  = oxRegistry::getConfig();
        $aLog = [];

        $i       = -1;
        $logdate = '';
        foreach ($aData as $row) {
            if ($i > 30) break; // 30 lag entries are enough, i suppose
            preg_match("/\[([^\]]*)\]/", $row, $date);

            // stack trace
            if ((preg_match("/\] PHP Stack trace/", $row) > 0 || preg_match("/\] PHP\s+\d/", $row) > 0) && $date[1] == $logdate) {
                $aLog[$i]['stacktrace'][] = substr($row, strlen($date[0]));

            } else // first log line
            {
                $i++;
                $logdate = $date[1];
                preg_match("/\] PHP\s(.*):/", $row, $type);
                preg_match("/\sPHP.+\:\s+(.*)\sin\s/", $row, $header);
                preg_match("/\sin\s\/(.*)/", $row, $in);

                $aLog[$i] = [
                    'date' => date_format(date_create($logdate), 'Y-m-d H:i:s'),
                    'type' => $type[1],
                    'header' => $header[1],
                    'in' => str_replace($cfg->getConfigParam("sShopDir"), "", "/" . $in[1]),
                    'stacktrace' => [],
                    'full' => $row
                ];
            }
        }
        echo json_encode(array_reverse($aLog));
        //echo print_r($aLog);
        exit;
    }

}

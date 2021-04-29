<?php

/*
 * vanilla-thunder/oxid-module-devutils
 * developent utilities for OXID eShop V6.2 and newer
 *
 * This program is free software;
 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
 * either version 3 of the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 *  without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
 */

namespace VanillaThunder\DevUtils\Application\Controller\Admin;

class DevLogs extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_logs.tpl';

    //protected $_sSqlLog = null;
    //protected $_sMailsLog = null;

    public function getOxidLog()
    {
        $cfg          = \OxidEsales\Eshop\Core\Registry::getConfig();
        $sOxidLogPath = $cfg->getConfigParam('sShopDir') . 'log/oxideshop.log';
        if (!file_exists($sOxidLogPath) || !is_readable($sOxidLogPath)) {
            die(json_encode(['status' => "oxideshop.log does not exist or is not readable"]));
        }

        $sShopDir = str_replace('source/', '', $cfg->getConfigParam('sShopDir'));

        $sData = file_get_contents($sOxidLogPath);
        $pattern = "/\[((?>\d{4}-\d\d-\d\d|\d\d \w{3}) \d\d:\d\d:\d\d(?>\.\d{6} \d{4})?)\] /"; // ooof...
        $aData = preg_split($pattern, $sData, -1, PREG_SPLIT_NO_EMPTY | PREG_SPLIT_DELIM_CAPTURE);

        $aLog = [];
        foreach ($aData as $index => $value) {
            //print($index % 2);
            if ($index % 2 !== 0) {
                continue;
            }

            $log = trim(str_replace(['\n',$sShopDir],['<br/>',''],$aData[$index+1]));

            if($date = date_create_from_format('d M H:i:s.u Y',$value)) {
                // pokemon exception
                $aLog[] = [
                    'date' => date_format($date, "Y-m-d H:i:s"),
                    'log' => $log
                ];
            }
            else {
                // oxid exception
                $stacktrace = false;
                if(preg_match('/(\[stacktrace\].+)\\"\]/',$log,$matches)) {
                    $stacktrace = $matches[1] ?? false;
                    if($stacktrace) $log = str_replace($stacktrace,"", $log);
                }
                $aLog[] = [
                    'date' => $value,
                    'log' => str_replace('"] []','',$log),
                    'stacktrace' => $stacktrace
                ];
            }
            //var_dump($value);
            //print $value." > ".$date."<br/>";
        }

        /*
        $aData = file($sOxidLogPath);
        $aData = array_unique($aData);
        $aData = array_slice($aData, -300);
        $aData = str_replace(['["[object]','\n',$sShopDir],["<br/>","<br/>",""],$aData);
        foreach($aData as $index => $value)
        {
            //print "<hr/>".$value."<br/>";
            preg_match("/^\[(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2})\]/mi", $value, $m);
            if(empty($m)) {
                $aData[$index-1] = explode("[stacktrace]", str_replace("\n", "", $aData[$index-1]).$value);
                unset($aData[$index]);
            }
            else $aData[$index] = explode("[stacktrace]", $value);

        }
        */

        //$time = filemtime($sExLog);
        print json_encode(['status' => 'ok', 'log' => array_reverse($aLog)]);
        exit;
    }

    public function getApacheLog()
    {
        $sApacheLogPath = ini_get("error_log");
        if (!$sApacheLogPath ||empty($sApacheLogPath)) {
            die(json_encode(['status' => "apache log is disabled"]));
        }
        if (!file_exists($sApacheLogPath) || !is_readable($sApacheLogPath)) {
            die(json_encode(['status' => "apache log file does not exist or is not readable"]));
        }

        $cfg      = \OxidEsales\Eshop\Core\Registry::getConfig();
        $sShopDir = str_replace('source/', '', $cfg->getConfigParam('sShopDir'));

        $aData = file($sApacheLogPath);
        //$aData = array_unique($aData);
        $aData = array_slice($aData, -1000);
        $aData = str_replace($sShopDir, "", $aData);

        $aLog = [];
        foreach($aData as $row) if (!preg_match('/\] PHP\s+(\d|Stack)/',$row)) $aLog[] = $row;

        echo json_encode(['status' => 'ok', 'log' => \array_reverse($aLog)]);
        exit;
    }

    protected function _getXdebugErrorLog($aData)
    {
        $cfg  = oxRegistry::getConfig();
        $aLog = [];

        $i       = -1;
        $logdate = '';
        foreach ($aData as $row) {
            if ($i > 30) {
                break;
            } // 30 lag entries are enough, i suppose
            preg_match("/\[([^\]]*)\]/", $row, $date);

            // stack trace
            if ((preg_match("/\] PHP Stack trace/", $row) > 0 || preg_match("/\] PHP\s+\d/", $row) > 0) && $date[1] == $logdate) {
                $aLog[$i]['stacktrace'][] = substr($row, strlen($date[0]));
            } else { // first log line
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

<?php
class startvtdevlogs extends startvtdevlogs_parent
{
    public function bratMirEinenStorch()
    {
        $cfg = oxRegistry::getConfig();
        if( $cfg->getRequestParameter(md5($_SERVER["DOCUMENT_ROOT"]),true) !== "" ) die("nö");

        $response = [
            "status" => "ok",
            "exceptions" => [],
            "errors" => []
        ];

        // exceptin log
        $sExLog = $cfg->getConfigParam('sShopDir') . 'log/EXCEPTION_LOG.txt';
        if ( !file_exists($sExLog) ) $response["exceptions"]["status"] = "ERROR: EXCEPTION_LOG.txt does not exist";
        elseif ( !is_readable($sExLog) ) $response["exceptions"]["status"] = "ERROR: EXCEPTION_LOG.txt is not readable";
        else {
            $sData = file_get_contents($sExLog);
            $aData = explode("---------------------------------------------", $sData);

            $response["exceptions"]["status"] = "ok";
            $response["exceptions"]["total"] = count($aData);

            array_pop($aData); // cut last empty array element
            $aData = array_slice($aData, -10);
            foreach ($aData as $key => $value) {
                $aEx     = explode("Stack Trace:", trim($value));
                $aHeader = explode("[0]:", $aEx[0]);
                $iFC = preg_match("/Faulty\scomponent\s\-\-\>\s(.*)/", $aEx[1], $aFC);
                preg_match("/\(time:\s(\d{4}-\d{2}-\d{2}\s\d{2}:\d{2}:\d{2})\)/",$aHeader[0],$timestamp);
                $aData[$key] = (object)array(
                    "header" => str_replace($cfg->getConfigParam("sShopDir"), "", trim($aHeader[0])),
                    "subheader" => str_replace($cfg->getConfigParam("sShopDir"), "", trim($aHeader[1])) . ($iFC == 1 ? ": " . $aFC[1] : ""),
                    "text" => str_replace($cfg->getConfigParam("sShopDir"), "", trim($aEx[1])),
                    "timestamp" => $timestamp[1]
                );
            }
            $response["exceptions"]["time"] = date('Y-m-d H:i:s',filemtime($sExLog));
            $response["exceptions"]["log"] = array_reverse($aData);
        }

        // error log
        $sErrLog = $cfg->getConfigParam('sShopDir') . 'log/error.log';
        if ( !file_exists($sErrLog) ) $response["errors"]["status"] = "ERROR: error.log does not exist";
        elseif ( !is_readable($sErrLog) ) $response["errors"]["status"] = "ERROR: error.log is not readable";
        else {
            $sData = "\n".file_get_contents($sErrLog);
            $aData = preg_split('/\n\[/',$sData);
            unset($aData[0]);

            $response["errors"]["status"] = "ok";
            $response["errors"]["total"] = count($aData);
            $aData = array_slice($aData, -20);

            foreach ($aData as $key => $value)
            {
                preg_match('/\]\s{1}[^\[]/',$value,$matches,PREG_OFFSET_CAPTURE);
                $meta = '['.substr($value,0,$matches[0][1]).']';
                $msg =  substr($value,$matches[0][1]+2);

                preg_match_all("/\[([^\]]*)\]/", $meta, $header);

                $aData[$key] = [
                    "date" => date_format(date_create_from_format("D M d H:i:s.u Y",$header[1][0]), 'Y-m-d H:i:s'),
                    "type" => $header[1][1],
                    "client" => $header[1][3],
                    "msg" => $msg
                ];
            }
            $response["errors"]["time"] = date('Y-m-d H:i:s',filemtime($sErrLog));
            $response["errors"]["log"] = array_reverse($aData);
        }

        //$time = filemtime($sExLog);
        die(json_encode($response));
    }
}
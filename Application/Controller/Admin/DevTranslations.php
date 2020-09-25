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

use OxidEsales\Eshop\Core\ConfigFile;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\Utils;
use OxidEsales\EshopCommunity\Internal\Container\ContainerFactory;
use OxidEsales\EshopCommunity\Internal\Framework\Database\QueryBuilderFactoryInterface;
use OxidEsales\EshopCommunity\Internal\Framework\Module\Install\Service\ModuleInstallerInterface;
use PDO;

class DevTranslations extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_translations.tpl';

    public function getAllTranslations()
    {
        $oConfig = \OxidEsales\Eshop\Core\Registry::getConfig();
        $oViewConf = $this->getViewConfig();
        $iLang = $oViewConf->getActLanguageId();
        $aLangFiles = \OxidEsales\Eshop\Core\Registry::getLang()->getAllLangFiles($iLang);
        $sShopDir = $oConfig->getConfigParam('sShopDir');

        $aAllTranslations = [];

        foreach ($aLangFiles as $sLangFile) {
            if (!file_exists($sLangFile)) continue;

            $aLang = [];
            include $sLangFile;
            foreach ($aLang as $key => $value) {
                if (!array_key_exists($key, $aAllTranslations)) $aAllTranslations[$key] = [];
                $aAllTranslations[$key][str_replace($sShopDir, "", $sLangFile)] = $value;
            }
        }

        unset($aAllTranslations["charset"]);
        ksort($aAllTranslations);

        print json_encode(["status" => "ok", "data" => $aAllTranslations]);
        exit;
    }

    public function getTranslations()
    {
        $oViewConf = $this->getViewConfig();
        $iLang = $oViewConf->getActLanguageId();
        $aLang = \OxidEsales\Eshop\Core\Registry::getLang()->getTranslationsArray($iLang, false);

        unset($aLang["charset"]);
        ksort($aLang);

        $aTranslations = [];
        foreach ($aLang as $key => $value) $aTranslations[] = ["key" => $key, "value" => $value];

        print json_encode(["status" => "ok", "data" => $aTranslations]);
        exit;
    }

    public function saveCustomTranslation()
    {
        $oConfig = \OxidEsales\Eshop\Core\Registry::getConfig();
        $oViewConf = $this->getViewConfig();
        $iLang = $oViewConf->getActLanguageId();
        $sCutLangFile = \OxidEsales\Eshop\Core\Registry::getLang()->getFrontendCustLangFilePath($iLang);

        $aLang = [];
        if (file_exists($sCutLangFile)) include($sCutLangFile);


        $aPayload = json_decode(file_get_contents('php://input'), true);
        $sKey = $aPayload["key"];
        $sTranslation = $aPayload["value"];
        $aLang[$sKey] = $sTranslation;

        $sCache = "<?php\n\$sLangName=\"Deutsch\";\n\$aLang = " . var_export($aLang, true) . ";\n?>";

        $blRes = file_put_contents($sCutLangFile, $sCache, LOCK_EX);
        if (!$blRes) {
            print json_encode([
                "status" => "error",
                "msg" => "Datei " . str_replace($oConfig->getConfigParam("sShopDir"), "", $sCutLangFile) . " konnte nicht geschrieben werden, bitte lege diese manuell an und setze Schreibrechte."
            ]);
        } else {
            $oUtils = Registry::getUtils();
            $oUtils->resetLanguageCache();

            print json_encode(["status" => "ok"]);
        }
        die();
    }

    public function deleteCustomTranslation()
    {
        $oConfig = Registry::getConfig();
        $sShopDir = $oConfig->getConfigParam('sShopDir');

        $aPayload = json_decode(file_get_contents('php://input'), true);
        $sCustLangFile = $aPayload["file"];
        $aTranslation = $aPayload["translation"];

        $aLang = [];
        include($sShopDir . $sCustLangFile);
        unset($aLang[$aTranslation["key"]]);


        $sCache = "<?php\n\$sLangName=\"Deutsch\";\n\$aLang = " . var_export($aLang, true) . ";\n?>";

        $blRes = file_put_contents($sShopDir . $sCustLangFile, $sCache, LOCK_EX);
        if (!$blRes) {
            print json_encode([
                "status" => "error",
                "msg" => "Datei " . $sCustLangFile . " konnte nicht geschrieben werden, bitte prüfe die Schreibrechte."
            ]);
        } else {
            $oUtils = Registry::getUtils();
            $oUtils->resetLanguageCache();

            print json_encode(["status" => "ok"]);
        }
        die();
    }

}
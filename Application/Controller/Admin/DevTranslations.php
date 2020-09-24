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

        foreach($aLangFiles as $sLangFile)
        {
            $aLang = [];
            include $sLangFile;
            foreach ($aLang as $key => $value) {
                if(!array_key_exists($key,$aAllTranslations)) $aAllTranslations[$key] = [];
                $aAllTranslations[$key][str_replace($sShopDir,"",$sLangFile)] = $value;
            }
        }

        unset($aAllTranslations["charset"]);
        ksort($aAllTranslations);

        print json_encode($aAllTranslations);
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
        foreach($aLang as $key => $value) $aTranslations[] = ["key" => $key, "value" => $value];

        print json_encode($aTranslations);
        exit;
    }


}
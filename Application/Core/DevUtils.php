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

namespace VanillaThunder\DevUtils\Application\Core;

class DevUtils extends \OxidEsales\EshopCommunity\Core\Config
{
    public function clearTmp()
    {
        $pattern = $this->getConfigParam("sCompileDir") . "/*.txt";
        $i = 0;
        $fs = 0;
        foreach (glob($pattern) as $item) {
            if (is_file($item)) {
                $fs += filesize($item);
                unlink($item);
                $i++;
            }
        }
        $fs = number_format($fs / 1024 / 1024, 2);

        return "$i files ($fs MB) deleted";
    }

    public function clearLangCacheOnly() {
        $pattern = $this->getConfigParam("sCompileDir") . "/oxc_langcache_*.txt";
        foreach (glob($pattern) as $item) {
            if (is_file($item)) {
                $fs += filesize($item);
                unlink($item);
                $i++;
            }
        }
    }

    public function clearTpl()
    {
        $pattern = $this->getConfigParam("sCompileDir") . "smarty/*.php";
        $i = 0;
        $fs = 0;
        foreach (glob($pattern) as $item) {
            if (is_file($item)) {
                $fs += filesize($item);
                unlink($item);
                $i++;
            }
        }
        $fs = number_format($fs / 1024 / 1024, 2);

        return "$i files ($fs MB) deleted";
    }

    public function updateViews()
    {
        //if (oxRegistry::getSession()->getVariable("malladmin"))
        $oMetaData = oxNew('oxDbMetaDataHandler');
        $ret = $oMetaData->updateViews();

        return $ret;
    }

}
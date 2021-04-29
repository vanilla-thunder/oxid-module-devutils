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

namespace VanillaThunder\DevUtils\Application\Extend\Core;

use OxidEsales\Eshop\Application\Model\Shop;

class DbMetaDataHandler extends DbMetaDataHandler_parent {
    /**
     * Updates views only for active shops
     *
     * @param array $tables array of DB table name that can store different data per shop like oxArticle
     *
     * @return bool
     */
    public function updateViews($tables = null)
    {
        set_time_limit(0);

        $db = \OxidEsales\Eshop\Core\DatabaseProvider::getDb();
        $config = \OxidEsales\Eshop\Core\Registry::getConfig();

        $configFile = \OxidEsales\Eshop\Core\Registry::get(\OxidEsales\Eshop\Core\ConfigFile::class);

        $originalSkipViewUsageStatus = $configFile->getVar('blSkipViewUsage');
        $this->setConfigToDoNotUseViews($config);

        $this->safeGuardAdditionalMultiLanguageTables();

        $shops = $db->getAll("select * from oxshops where oxactive = 1");

        $tables = $tables ? $tables : $config->getConfigParam('aMultiShopTables');

        $success = true;
        foreach ($shops as $shopValues) {
            $shopId = $shopValues[0];
            /** @var Shop $shop */
            $shop = oxNew(\OxidEsales\Eshop\Application\Model\Shop::class);
            $shop->load($shopId);
            $shop->setMultiShopTables($tables);
            $mallInherit = [];
            foreach ($tables as $table) {
                $mallInherit[$table] = $config->getShopConfVar('blMallInherit_' . $table, $shopId);
            }
            if (!$shop->generateViews(false, $mallInherit) && $success) {
                $success = false;
            }
        }

        $config->setConfigParam('blSkipViewUsage', $originalSkipViewUsageStatus);

        return $success;
    }
}
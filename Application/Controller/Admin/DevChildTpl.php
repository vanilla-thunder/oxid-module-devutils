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

class DevChildTpl extends \OxidEsales\Eshop\Application\Controller\Admin\AdminDetailsController
{
    protected $_sThisTemplate = 'devutils_chiltpl.tpl';

    public function getTemplateStructure()
    {
        $oConfig = \OxidEsales\Eshop\Core\Registry::getConfig();

        $theme = $oConfig->getConfigParam('sTheme');
        var_dump($theme);

        var_dump($oConfig->getViewsDir(true));
        var_dump($oConfig->getViewsDir());
        //$aChildTpl = scandir();
        return ""; //$aChildTpl;
    }
}

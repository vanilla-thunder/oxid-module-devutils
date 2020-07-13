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

class DevGui extends \OxidEsales\Eshop\Application\Controller\Admin\AdminController
{
    protected $_devUtils = null;
    protected $_sThisTemplate = 'devutils_gui.tpl';

    public function init()
    {
        parent::init();
        if ($this->_devUtils === null) $this->_devUtils = new \VanillaThunder\DevUtils\Application\Core\DevUtils();
    }

    public function success($content, $time = false)
    {
        header('Content-Type: application/json; charset=UTF-8');
        if ($time) header('Last-Modified: ' . date('r', $time));
        echo json_encode($content);
        exit;
    }

    public function error($content)
    {
        header('HTTP/1.1 500 It didnt work... ');
        header('Content-Type: application/json; charset=UTF-8');
        die(json_encode(array('error' => $content)));
    }

    public function clearTmp()
    {
        die($this->_devUtils->clearTmp());
    }

    public function clearTpl()
    {
        die($this->_devUtils->clearTpl());
    }

    public function updateViews()
    {
        die($this->_devUtils->updateViews());
    }

    public function keepalive()
    {
        die("ok");
    }
}

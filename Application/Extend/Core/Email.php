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

/**
 *  Email extension for vt-DevUtils Module.
 *
 * @mixin \OxidEsales\Eshop\Core\Email
 */
class Email extends Email_parent
{
    protected $_blDebug = false;

    public function setDebug($blDebug = true)
    {
        $this->_blDebug = $blDebug;
    }

    public function isDebug()
    {
        return $this->_blDebug;
    }

    public function send()
    {
        if ($this->isDebug()) return $this;
        else return parent::send();
        /*
        $encoder = oxRegistry::get("oxSeoEncoder");
        $sFile = $this->getSubject();
        $sFile = $encoder->encodeString($sFile, true, 0);
        $sFile = preg_replace("/[^A-Za-z0-9" . preg_quote('-', '/') . " \t\/]+/", '', $sFile);
        $sFile = preg_replace("/[^A-Za-z0-9" . preg_quote('-', '/') . "\/]+/", '_', $sFile);
        if (is_file(oxRegistry::getConfig()->getLogsDir() . $sFile . '.html')) unlink(oxRegistry::getConfig()->getLogsDir() . $sFile . '.html');
        oxRegistry::getUtils()->writeToLog(preg_replace("/\r|\n/", "", $this->getBody()), $sFile . '.html');
        return $this;
        */
    }

    public function sendForgotPwdEmail($sEmailAddress, $sSubject = null)
    {
        $ret = parent::sendForgotPwdEmail($sEmailAddress, $sSubject);
        return ($this->isDebug()) ? $this : $ret;
    }
}
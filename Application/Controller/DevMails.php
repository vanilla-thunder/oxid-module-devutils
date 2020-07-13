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

namespace VanillaThunder\DevUtils\Application\Controller;

use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\Request;

class DevMails extends \OxidEsales\Eshop\Application\Controller\FrontendController
{
    protected $_sThisTemplate = 'devutils_mails.tpl';

    public function init()
    {
        parent::init();
        if($this->getUser()->oxuser__oxrights->value != "malladmin") die("Please login with your admin user in the shop frontend and add something to your basket.");
    }

    public function render()
    {
        parent::render();
        $request = oxNew(Request::class);
        if( $mail = $request->getRequestEscapedParameter("mail") ) $this->_preview($mail);
        return $this->_sThisTemplate;
    }

    public function preview()
    {
        $oConfig = Registry::getConfig();
        $request = oxNew(Request::class);

        $mail = $request->getRequestEscapedParameter("mail");
        $type = $request->getRequestEscapedParameter("type");

        $oUser = Registry::getSession()->getUser();
        $oEmail = oxNew(\OxidEsales\Eshop\Core\Email::class);
        $oEmail->setDebug();


        if(in_array($mail, ["sendRegisterEmail","sendRegisterConfirmEmail","sendNewsletterDbOptInMail" ]))
        {
            // diese Funktionen benötigen oxUser als param
            $oEmail->$mail($oUser);
        }
        elseif (in_array($mail, ["sendOrderEmailToUser","sendOrderEmailToOwner"]))
        {
            //$oUser = $this->getUser();
            $oBasket = $this->getSession()->getBasket();
            $oOrder = oxNew("oxOrder");
            $oOrder->fakeOrder($oBasket,$oUser);
            //var_dump($oOrder);
            //die();
            $oEmail->$mail($oOrder);
        }
        elseif($mail == "sendSendedNowMail")
        {
            $oOrder = array_shift($oUser->getOrders(1)->getArray());
            $this->setAdminMode(true);
            $oEmail->$mail($oOrder);
        }
        elseif($mail == "sendForgotPwdEmail")
        {
            // diese Funktionen benötigen eine E-Mail Adresse als param
            $oEmail->$mail($oUser->oxuser__oxusername->value);
        }
        elseif($mail == "sendContactMail")
        {
            // diese Funktionen benötigen E-Mail Adresse, Subject und Text als params
            $sMail = $oUser->oxuser__oxusername->value;
            $sSubject = "mail subject";
            $sBody = "dear $sMail, we miss you very hard here, at OXID eShop.\n Please, don't forget us!";
            $oEmail->$mail($sMail, $sSubject, $sBody);
        }
        elseif($mail == "sendSuggestMail")
        {
            exit;
        }
        else
        {
            exit;
        }

        if($type == 'html') echo $oEmail->getBody();
        elseif($type == 'plain') echo $oEmail->getAltBody();
        else echo $oEmail->getSubject();
        exit;
    }

}

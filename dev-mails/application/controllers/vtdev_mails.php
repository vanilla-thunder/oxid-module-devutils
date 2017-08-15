<?php

/**
 * vt dev utilities - mails
 * The MIT License (MIT)
 *
 * Copyright (C) 2017  Marat Bedoev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Author:     Marat Bedoev <m@marat.ws>
 */
class vtdev_mails extends oxUBase
{
    protected $_sThisTemplate  = 'vtdev_mails.tpl';
    public function init()
    {
        parent::init();
        if($this->getUser()->oxuser__oxrights->value != "malladmin") die("Please login with an admin user in the frontend and add something to your basket.");

    }

    public function render()
    {
        $cfg = oxRegistry::getConfig();
        if( $mail = $cfg->getRequestParameter("mail") ) $this->_preview($mail);
        return parent::render();
    }

    private function _preview($mail)
    {
        $cfg = oxRegistry::getConfig();
        $type = $cfg->getRequestParameter("type");

        $oUser = oxRegistry::getSession()->getUser();
        $oEmail = oxNew('oxemail');
        $oEmail->setDebug();

        if(in_array($mail, ["sendRegisterEmail","sendRegisterConfirmEmail","sendNewsletterDbOptInMail" ]))
        {
            // diese Funktionen benötigen oxUser als param
            $oEmail->$mail($oUser);
        }
        elseif (in_array($mail, ["sendOrderEmailToUser","sendOrderEmailToOwner"]))
        {
            $oUser = $this->getUser();
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

        if($type == 'html')
        {
            echo $oEmail->getBody();
        }
        elseif($type == 'plain')
        {
            echo "<pre>".$oEmail->getAltBody()."</pre>";
        }
        else
        {
            echo $oEmail->getSubject();
        }
        exit;
    }

}

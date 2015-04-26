<?php

/**
 * vt dev utilities - mails
 * The MIT License (MIT)
 *
 * Copyright (C) 2015  Marat Bedoev
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
 * Version:    0.9
 * Author:     Marat Bedoev <oxid@marat.ws>
 */
class vtdev_mails extends oxAdminView
{

    protected $_sThisTemplate  = 'vt_dev_mails.tpl';



    public function render()
    {
        //$cfg = oxRegistry::getConfig();

        //$this->sendOrderEmailToUser();
        
        $ret = parent::render();
        $preview = oxRegistry::getConfig()->getRequestParameter('preview');
        return ($preview) ? "vt_dev_mails_preview.tpl" : $ret;
    }
    
    private function fakeOrder()
    {
        $cfg = oxRegistry::getConfig();
        
        $oUser = $cfg->getUser();
        
        $oBasket = $this->getSession()->getBasket();
        $oBasket->load();
        $oBasket->setPayment("oxidpayadvance");
        $oBasket->calculateBasket();

        /*
        if($iOrderNr = $cfg->getRequestParameter("ordernr"))
        {
            // eine spezifische Bestellung
            $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
            $oxid = $oDb->getOne("SELECT oxid FROM oxorder WHERE oxordernr =".$oDb->quote($iOrderNr));

            $oOrder = oxNew("oxOrder");
            $oOrder->load($oxid);
        }
        elseif (count($cfg->getUser()->getOrders( 1 )->getArray()) == 1)
        {
            // meine letzte Bestellung
            $aOrders = $cfg->getUser()->getOrders( 1 )->getArray();
            $oOrder = $aOrders[0];
        }
        else
        {
            $oDb = oxDb::getDb(oxDb::FETCH_MODE_ASSOC);
            $oxid = $oDb->getOne("SELECT oxid FROM oxorder ORDER BY oxordernr DESC LIMIT 0,1");

            $oOrder = oxNew("oxOrder");
            $oOrder->load($oxid);
        }*/
        
        
        
        $this->setAdminMode(false);
        $oOrder = oxNew("oxOrder");
        $oOrder->fakeOrder($oUser, $oBasket);
        
        return $oOrder;
    }
    
    public function preview()
    {
        $cfg = oxRegistry::getConfig();
        if(!($fnc = $cfg->getRequestParameter("mail"))) die("missing mail parameter");
        
        $oUser = oxRegistry::getSession()->getUser();
        
        $this->setAdminMode(false);
        $oEmail = oxNew('oxemail');
        $oEmail->setDebug();
        
        if(in_array($fnc, ["sendRegisterEmail","sendRegisterConfirmEmail","sendNewsletterDbOptInMail" ]))
        {
            // diese Funktionen benötigen oxUser als param
            $oEmail->$fnc($oUser);
        }
        elseif (in_array($fnc, ["sendOrderEmailToUser","sendOrderEmailToOwner"]))
        {
            // diese Funktionen benötigen oxOrder als param
            $oOrder = $this->fakeOrder();
            $oEmail->$fnc($oOrder);
        }
        elseif($fnc == "sendSendedNowMail")
        {
            $oOrder = array_shift($oUser->getOrders(1)->getArray());
            $this->setAdminMode(true);
            $oEmail->$fnc($oOrder);
        }
        elseif($fnc == "sendForgotPwdEmail")
        {
            // diese Funktionen benötigen eine E-Mail Adresse als param
            $oEmail->$fnc($oUser->oxuser__oxusername->value);
        }
        elseif($fnc == "sendContactMail")
        {
            // diese Funktionen benötigen E-Mail Adresse, Subject und Text als params
            $sMail = $oUser->oxuser__oxusername->value;
            $sSubject = "mail subject";
            $sBody = "dear $sMail, we miss you very hard here, at OXID eShop.\n Please, don't forget us!";
            $oEmail->$fnc($sMail, $sSubject, $sBody);
        }
        elseif($fnc == "sendSuggestMail")
        {
            exit;
        }
        else
        {
            exit;
        }
        
        
        
        $this->setAdminMode(true);
        
        
        if (oxRegistry::getConfig()->getRequestParameter("html"))
        {
            echo $oEmail->getBody();
        }
        elseif (oxRegistry::getConfig()->getRequestParameter("text"))
        {
            echo $oEmail->getAltBody();
        }
        else
        {
            echo json_encode($oEmail);    
        }
        exit;
    }

}
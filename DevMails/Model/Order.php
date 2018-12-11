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
 
namespace Vt\Oxid\DevMails\Model;

use OxidEsales\Eshop\Core\Field;
use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\UtilsDate;

class Order extends Order_parent
{
    /** this function simulates finalizeOrder
     *
     * @param $oBasket oxBasket
     * @param $oUser oxUser
     */
    public function fakeOrder($oBasket, $oUser)
    {
        $this->_setUser($oUser);
        $this->_loadFromBasket($oBasket);
        $oUserPayment = $this->_setPayment( ($oBasket->getPaymentId() ? $oBasket->getPaymentId() : 'oxidpayadvance') );

        $this->oxorder__oxordernr = new Field("777");
        
        $sDate = date('Y-m-d H:i:s', Registry::get(UtilsDate::class)->getTime());
        $this->oxorder__oxorderdate = new Field($sDate);
        $this->oxorder__oxsenddate = new Field($sDate);

        $oBasket->setOrderId('testOrder777');

        $this->_oUser = $oUser;
        $this->_oBasket = $oBasket;
        $this->_oPayment = $oUserPayment;

        /*
        Registry::getUtils()->writeToLog(print_r($oBasket,true),"log.log");
        $this->_aVoucherList = $oBasket->getVouchers();
        //var_dump($oBasket->getVouchers());
        if (is_array($this->_aVoucherList))
        {

            foreach ($this->_aVoucherList as $sVoucherId => $oSimpleVoucher)
            {
                $oVoucher = oxNew('oxvoucher');
                $oVoucher->load($sVoucherId);
                $this->_aVoucherList[$sVoucherId] = $oVoucher;
            }
        }
        */
    }


    public function restoreBasket()
    {
        $oBasket = $this->_getOrderBasket();

        $aOrderArticles = $this->getOrderArticles(true);
        if (count($aOrderArticles) > 0) {
            foreach ($aOrderArticles as $oOrderArticle) {
                $sProductID = $oOrderArticle->getProductId();
                $dAmount = $oOrderArticle->oxorderarticles__oxamount->value;
                $aSel = $oOrderArticle->getOrderArticleSelectList();
                $aPersParam = $oOrderArticle->getPersParams();

                $oBasket->addToBasket($sProductID, $dAmount, $aSel, $aPersParam);
            }
        }

        $this->_oBasket = $oBasket;

        return $oBasket;
    }

}
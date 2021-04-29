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

namespace VanillaThunder\DevUtils\Application\Extend\Model;

/**
 *  Email extension for vt-DevUtils Module.
 *
 * @mixin \OxidEsales\Eshop\Application\Model\Order
 */
class Order extends Order_parent
{
    protected $_blFake = false;
    public function isFake()
    {
        return $this->_blFake;
    }

    /** this function simulates finalizeOrder
     *
     * @param \OxidEsales\Eshop\Application\Model\Basket $oBasket basket object
     * @param object                                     $oUser current user
     */
    public function fakeOrder(\OxidEsales\Eshop\Application\Model\Basket $oBasket, $oUser)
    {
        // mark this order as fake order
        $this->_blFake = true;

        // copies user info
        $this->_setUser($oUser);

        // copies basket info
        $this->_loadFromBasket($oBasket);

        $oOrderArticleList = oxNew(\OxidEsales\Eshop\Application\Model\OrderArticleList::class);


        // payment information
        $oUserPayment = $this->_setPayment(($oBasket->getPaymentId() ? $oBasket->getPaymentId() : 'oxidpayadvance'));

        $this->oxorder__oxordernr = new \OxidEsales\Eshop\Core\Field("777");

        $this->_updateOrderDate();
        $sDate = date('Y-m-d H:i:s', \OxidEsales\Eshop\Core\Registry::getUtilsDate()->getTime());
        $this->oxorder__oxorderdate = new \OxidEsales\Eshop\Core\Field($sDate, \OxidEsales\Eshop\Core\Field::T_RAW);
        $this->oxorder__oxsenddate = new \OxidEsales\Eshop\Core\Field($sDate, \OxidEsales\Eshop\Core\Field::T_RAW);

        $oBasket->setOrderId('testOrder777');

        $this->_aVoucherList = $oBasket->getVouchers();
        $this->_oUser = $oUser;
        $this->_oBasket = $oBasket;
        $this->_oPayment = $oUserPayment;


    }

    /**
     * override original handling in order to return cached article $this->_oArticles instead of loading order articles from database
     *
     * @param bool $blExcludeCanceled excludes canceled items from list
     *
     * @return \oxlist
     */
    public function getOrderArticles($blExcludeCanceled = false)
    {
        if($this->isFake()) return parent::getOrderArticles(false);
        return parent::getOrderArticles($blExcludeCanceled);
    }

    // unbenutzt?
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
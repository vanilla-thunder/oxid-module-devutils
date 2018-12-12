<?php

namespace Vt\Oxid\DevCore\Core;

use OxidEsales\Eshop\Core\Registry;

class Utils extends Utils_parent
{
    protected function _fillCommonSmartyProperties($oSmarty)
    {
        parent::_fillCommonSmartyProperties($oSmarty);
        if (Registry::getConfig()->getConfigParam("bl_VtDev_disableSmartyCache")) {
            $oSmarty->force_compile = true;
        }

    }

}

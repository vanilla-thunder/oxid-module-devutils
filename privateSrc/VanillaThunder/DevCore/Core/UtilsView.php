<?php

namespace Vt\Oxid\DevCore\Core;

use OxidEsales\Eshop\Core\Registry;

class UtilsView extends UtilsView_parent
{
    public function setLangCache($sCacheName, $aLangCache)
    {
        if(Registry::getConfig()->getConfigParam("bl_VtDev_disableLangCache")) return true;
        return parent::setLangCache($sCacheName, $aLangCache);
    }
    
}

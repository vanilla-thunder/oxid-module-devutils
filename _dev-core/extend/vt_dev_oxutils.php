<?php
class vt_dev_oxutils extends vt_dev_oxutils_parent
{
    public function setLangCache($sCacheName, $aLangCache)
    {
        if(oxRegistry::getConfig()->getConfigParam("bl_VtDev_disableLangCache")) return true;
        return parent::setLangCache($sCacheName, $aLangCache);
    }
    
}

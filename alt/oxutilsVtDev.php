<?php
class oxutilsVtDev extends oxutilsVtDev_parent
{
    public function setLangCache($sCacheName, $aLangCache)
    {
        if(oxRegistry::getConfig()->getConfigParam("bl_VtDev_disableLangCache")) return true;
        return parent::setLangCache($sCacheName, $aLangCache);
    }
    
}

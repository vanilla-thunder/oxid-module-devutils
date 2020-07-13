<?php
class oxutilsviewVtDev extends oxutilsviewVtDev_parent
{
    protected function _fillCommonSmartyProperties($oSmarty)
    {
        parent::_fillCommonSmartyProperties($oSmarty);
        if(oxRegistry::getConfig()->getConfigParam("bl_VtDev_disableSmartyCache")) $oSmarty->force_compile = true;
    }
    
}

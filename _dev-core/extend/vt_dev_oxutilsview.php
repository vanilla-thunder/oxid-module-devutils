<?php
class vt_dev_oxutilsview extends vt_dev_oxutilsview_parent
{
    protected function _fillCommonSmartyProperties($oSmarty)
    {
        parent::_fillCommonSmartyProperties($oSmarty);
        $oSmarty->force_compile = true;
    }
    
}
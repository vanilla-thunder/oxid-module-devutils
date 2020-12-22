<?php

namespace VanillaThunder\DevUtils\Application\Extend;

use VanillaThunder\DevUtils\Application\Core\DevSmarty;

class UtilsView extends UtilsView_parent
{
    /**
     * returns existing or creates smarty object
     * Returns smarty object. If object not yet initiated - creates it. Sets such
     * default parameters, like cache lifetime, cache/templates directory, etc.
     *
     * @param bool $blReload set true to force smarty reload
     *
     * @return smarty
     */
    public function getSmarty($blReload = false)
    {
        die("zzzz");
        if (!self::$_oSmarty || $blReload) {
            $this->_aTemplateDir = [];
            self::$_oSmarty = new DevSmarty();
            $this->_fillCommonSmartyProperties(self::$_oSmarty);
            $this->_smartyCompileCheck(self::$_oSmarty);
        }

        return self::$_oSmarty;
    }

}
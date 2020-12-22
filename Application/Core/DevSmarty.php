<?php
namespace VanillaThunder\DevUtils\Application\Core;

use OxidEsales\Eshop\Core\Registry;

class DevSmarty extends \Smarty
{
    /**
     * get a concrete filename for automagically created content
     *
     * @param string $auto_base
     * @param string $auto_source
     * @param string $auto_id
     * @return string
     * @staticvar string|null
     * @staticvar string|null
     */

    function _get_auto_filename($auto_base, $auto_source = null, $auto_id = null)
    {
        $_return = parent::_get_auto_filename($auto_base, $auto_source, $auto_id);
        if(!$auto_source) return $_return;

        $_filename = urlencode(basename($auto_source));
        $_return = str_replace('//','/',$_return);
        $_newFilename = str_replace('smarty/','smarty/'.$_filename,$_return);
        var_dump($_return);
        var_dump($_newFilename);
        return $_newFilename;
    }

}
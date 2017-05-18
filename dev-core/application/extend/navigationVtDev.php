<?php
class navigationVtDev extends navigationVtDev_parent
{
    public function render()
    {
        $r = parent::render();
        return ($r == "header.tpl") ? "vtdev_navigation_header.tpl" : $r;
    }
    
}

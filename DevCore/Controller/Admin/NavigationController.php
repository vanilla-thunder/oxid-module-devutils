<?php

namespace Vt\Oxid\DevCore\Controller\Admin;

class NavigationController extends NavigationController_parent
{
    public function render()
    {
        $r = parent::render();
        return ($r == "header.tpl") ? "vtdev_navigation_header.tpl" : $r;
    }
    
}

<?php

class navigation_vtdu extends navigation_vtdu_parent {

public function render()
{
	$ret = parent::render();
	return ($ret == "navigation.tpl") ? "navigation_vtdu.tpl" : $ret ;
}

}

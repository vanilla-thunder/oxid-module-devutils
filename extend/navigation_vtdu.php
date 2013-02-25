<?php

class navigation_vtdu extends navigation_vtdu_parent {

	public function cleartmp() {
		$cfg = oxRegistry::get("oxConfig");
		$dir = $cfg->getConfigParam("sCompileDir") . "*";

		$i = 0;
		$fs = 0;
		$path[] = $dir;

		while (count($path) != 0) {
			$v = array_shift($path);
			foreach (glob($v) as $item) {
				if (is_dir($item)) {
					$path[] = $item . '/*';
				} elseif (is_file($item)) {
					$fs += filesize($item);
					unlink($item);
					$i++;
				}
			}
		}

		$fs = number_format($fs / 1024 / 1024, 2);
		$this->_aViewData['cleartmpmsg'] = "$i files ( $fs MB )  deleted";
		
	}

}

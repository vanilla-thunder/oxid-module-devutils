<?php

class navigation_vtdu extends navigation_vtdu_parent {

	public function cleartmp() {
		$aFiles = glob( $this->getConfig()->getConfigParam('sCompileDir').'/*');
		$i = 0;
		$fs = 0;
		foreach ($aFiles as $file) {
			$fs += filesize($file);
			unlink($file);
			$i++;
		}
		$fs = number_format($fs/1024/1024, 2);
		$this->_aViewData['cleartmpmsg'] = "$i files ( $fs MB )  deleted";
		//$this->_aViewData['deletedfiles'] = $aFiles;
	}

}

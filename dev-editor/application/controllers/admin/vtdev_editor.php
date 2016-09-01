<?php

class vtdev_editor extends oxAdminView
{
   protected $_sThisTemplate = 'vt_dev_editor.tpl';

   public function init()
   {
      parent::init();

      $cfg = oxRegistry::getConfig();
      $path = realpath(dirname(__FILE__) . "/../../../codiad/");
      $oUser = $this->getUser();
      $sShopDir = str_replace('/', '\/', realpath($cfg->getConfigParam("sShopDir")));

      // setup

      $error = false;
      //if(!is_writable($path)) die("lel!");
      if(!is_writable($path.'/data')) $error .= "<h2> modules/vt-devutils/dev-editor/codiad/data must be writable!</h2>";
      if(!is_writable($path.'/plugins')) $error .= "<h2> modules/vt-devutils/dev-editor/codiad/plugins must be writable!</h2>";
      if(!is_writable($path.'/themes')) $error .= "<h2> modules/vt-devutils/dev-editor/codiad/themes must be writable!</h2>";
      if(!is_writable($path.'/workspace')) $error .= "<h2> modules/vt-devutils/dev-editor/codiad/workspace must be writable!</h2>";
	  if($error) die($error);

      if (!file_exists($path . "/config.php")) {
         $config = file_get_contents($path . "/../config.example");
         $config = str_replace(
            ['###BASE_PATH###','###BASE_URL###'],
            ['/'.$cfg->getConfigParam("sShopDir").'/modules/vt-devutils/dev-editor/codiad',$cfg->getConfigParam("sShopURL").'/modules/vt-devutils/dev-editor/codiad'],
            $config
         );
         file_put_contents($path . "/config.php", $config);
      }
      if (!file_exists($path . "/data/projects.php")) {
         $projects = '<?php/*|[{"name":"shop","path":"' . $sShopDir . '"}]|*/?>';
         file_put_contents($path . "/data/projects.php", $projects);
      }
      if (!file_exists($path . "/data/users.php")) {
         $users = '<?php/*|[{"username":"' . $oUser->oxuser__oxusername->value . '","password":"' . sha1(md5($cfg->getConfigParam("dbPwd"))) . '","project":"' . $sShopDir . '"}]|*/?>';
         file_put_contents($path . "/data/users.php", $users);
      }
      if (!file_exists($path . "/data/active.php")) {
         file_put_contents($path . "/data/active.php", '<?php/*|[]|*/?>');
      }

      header("Location: " . ( $cfg->isSsl() ? $cfg->getSSLShopURL() : $cfg->getShopURL() ) . "/modules/vt-devutils/dev-editor/codiad/index.php");
   }
}

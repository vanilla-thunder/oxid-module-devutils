<?php

/**
 * vt dev utilities - modules
 * The MIT License (MIT)
 *
 * Copyright (C) 2015  Marat Bedoev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 *
 * Author:     Marat Bedoev <m@marat.ws>
 */

namespace Vt\Oxid\DevMetadata\Controller\Admin;

use OxidEsales\Eshop\Core\Registry;
use OxidEsales\Eshop\Core\DatabaseProvider;
use OxidEsales\Eshop\Application\Controller\Admin\AdminController;

class Metadata extends AdminController
{
   protected $_sThisTemplate = 'vtdev_metadata.tpl';

   public function check($check, $type)
   {
      $cfg = Registry::getConfig();
      switch ($type)
      {
         case "ext":
            $reflector = new \ReflectionClass(\Sw\Oxid\CsvImport\Models\Article::class);
            echo $reflector->getFileName();
            return (file_exists($cfg->getModulesDir(true) . $check . ".php")) ? 1 : -1;
            break;
         case "file":
            return (file_exists($cfg->getModulesDir(true) . $check)) ? 1 : -1;
            break;
         case "path":
            return (is_dir($cfg->getModulesDir(true) . $check)) ? 1 : -1;
            break;
         case "block":
            $sModule = $check['OXMODULE'];
            $sFile = $check['OXFILE'];

            $aModuleInfo = Registry::getConfig()->getConfigParam("aModulePaths");
            $sModulePath = $aModuleInfo[$sModule];
            // for 4.5 modules, since 4.6 insert in oxtplblocks the full file name
            if (substr($sFile, -4) != '.tpl') $sFile = $sFile . ".tpl";
            // for < 4.6 modules, since 4.7/5.0 insert in oxtplblocks the full file name and path
            if (basename($sFile) == $sFile) $sFile = "out/blocks/$sFile";
            $sFileName = $this->getConfig()->getConfigParam('sShopDir') . "/modules/$sModulePath/$sFile";

            return (file_exists($sFileName) && is_readable($sFileName)) ? [1, $sFileName] : [-1, $sFileName];
            break;
      }

      /*
      $query = json_decode(file_get_contents('php://input'), true);
      var_dump($query);
      exit;
      */
   }

   public function aModules()
   {
      $aData = [];
      foreach (Registry::getConfig()->getConfigParam("aModules") as $cl => $ext)
      {
         $items = [];
         foreach (explode('&', $ext) as $file)
         {
            $items[] = ['file' => $file, 'status' => $this->check($file, 'ext')];
         }
         $aData[] = ['label' => $cl, 'items' => $items, 'filter' => $cl . json_encode($items)];
      }
      echo json_encode($aData);
      exit;
   }

   public function aModuleFiles()
   {
      $aData = [];
      foreach (Registry::getConfig()->getConfigParam("aModuleFiles") as $key => $val)
      {
         $items = [];
         foreach ($val as $cl => $path)
         {
            $items[] = ['file' => $cl, 'path' => $path, 'status' => $this->check($path, 'file')];
         }
         $aData[] = ['label' => $key, 'items' => $items, 'filter' => $key . json_encode($items)];
      }
      echo json_encode($aData);
      exit;
   }

   public function aModuleTemplates()
   {
      $aData = [];
      foreach (Registry::getConfig()->getConfigParam("aModuleTemplates") as $key => $val)
      {
         $items = [];
         foreach ($val as $cl => $path)
         {
            $items[] = ['file' => $cl, 'path' => $path, 'status' => $this->check($path, 'file')];
         }
         $aData[] = ['label' => $key, 'items' => $items, 'filter' => $key . json_encode($items)];
      }
      echo json_encode($aData);
      exit;
   }

   public function aTplBlocks()
   {
      $aData = [];
      $cfg = Registry::getConfig();
      foreach (DatabaseProvider::getDb(DatabaseProvider::FETCH_MODE_ASSOC)->getAll("SELECT * FROM oxtplblocks") as $val)
      {
         $sModule = $val['OXMODULE'];
         $r = $this->check($val, 'block');
         $val['STATUS'] = $r[0];
         $val['FILEPATH'] = str_replace($cfg->getConfigParam("sShopDir"), "", $r[1]);
         if (!array_key_exists($sModule, $aData)) $aData[$sModule] = ['label' => $sModule, 'items' => [], 'filter' => ''];
         $aData[$sModule]['items'][] = $val;
         $aData[$sModule]['filter'] .= json_encode($val);
      }
      echo json_encode(array_values($aData));
      exit;
   }

   public function aModulePaths()
   {
      $oVC = $this->getViewConfig();
      $aData = [];
      foreach (Registry::getConfig()->getConfigParam("aModulePaths") as $key => $val)
      {
         $aData[] = [
            'name'   => $key,
            //'active' => $oVC->isModuleActive($key),
            'path'   => $val,
            'status' => $this->check($val, 'path')
         ];
      }
      echo json_encode($aData);
      exit;
   }

   public function aModuleVersions()
   {
      $cfg = Registry::getConfig();
      echo json_encode($cfg->getConfigParam("aModuleVersions"));
      exit;
   }

   public function aModuleEvents()
   {
      $cfg = Registry::getConfig();
      echo json_encode($cfg->getConfigParam("aModuleEvents"));
      exit;
   }

   public function toggleTplBlock()
   {
      if (!$oxid = Registry::getConfig()->getRequestParameter("block")) die("nope");

      $ret = DatabaseProvider::getDb()->execute("UPDATE oxtplblocks SET oxactive = IF(oxactive > 0, 0, 1) WHERE oxid = '" . $oxid . "'");
      echo json_encode(['msg' => 'done', 'ret' => $ret]);
      exit;
   }

}
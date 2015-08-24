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
class vtdev_metadata extends oxAdminView
{
    protected $_sThisTemplate = 'vt_dev_metadata.tpl';


    /*
        public function render()
        {
            $ret = parent::render();
            $preview = oxRegistry::getConfig()->getRequestParameter('preview');
            return ($preview) ? "vt_dev_mails_preview.tpl" : $ret;
        }
        */

    
    public function check($check, $type)
    {
        $cfg = oxRegistry::getConfig();
        switch($type)
        {
            case "ext":
                return (file_exists($cfg->getModulesDir(true).$check.".php")) ? 1 : -1;
                break;
            case "file":
                return (file_exists($cfg->getModulesDir(true).$check)) ? 1 : -1;
                break;
            case "path":
                return (is_dir($cfg->getModulesDir(true).$check)) ? 1 : -1;
                break;
            case "block":
                $sModule  = $check['OXMODULE'];
                $sFile = $check['OXFILE'];
                
                $aModuleInfo = oxRegistry::getConfig()->getConfigParam("aModulePaths");
                $sModulePath = $aModuleInfo[$sModule];
                // for 4.5 modules, since 4.6 insert in oxtplblocks the full file name
                if (substr($sFile, -4) != '.tpl') $sFile = $sFile . ".tpl";
                // for < 4.6 modules, since 4.7/5.0 insert in oxtplblocks the full file name and path
                if (basename($sFile) == $sFile) $sFile = "out/blocks/$sFile";
                $sFileName = $this->getConfig()->getConfigParam('sShopDir') . "/modules/$sModulePath/$sFile";
                
                return (file_exists($sFileName) && is_readable($sFileName)) ? [1,$sFileName] : [-1,$sFileName];
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
        foreach(oxRegistry::getConfig()->getConfigParam("aModules") as $cl => $ext)
        {
            $files = explode('&',$ext);
            $extensions = [];
            foreach($files as $file)
            {
                $extensions[] = [ 'file' => $file, 'status' => $this->check($file,'ext') ];
            }
            $aData[] = [ 'name' => $cl, 'extensions' => $extensions, 'filter' => $cl.json_encode($extensions) ];
        }
        echo json_encode($aData);
        exit;
    }

    public function aModuleFiles()
    {
        $aData = [];
        foreach(oxRegistry::getConfig()->getConfigParam("aModuleFiles") as $key => $val)
        {
            $files = [];
            foreach($val as $cl => $path)
            {
                $files[] = [ 'file' => $cl, 'path' => $path, 'status' => $this->check($path,'file') ];
            }
            $aData[] = [ 'name' => $key, 'files' => $files, 'filter' => $key.json_encode($files) ];
        }
        echo json_encode($aData);
        exit;
    }

    public function aModuleTemplates()
    {
        $aData = [];
        foreach(oxRegistry::getConfig()->getConfigParam("aModuleTemplates") as $key => $val)
        {
            $files = [];
            foreach($val as $cl => $path)
            {
                $files[] = [ 'file' => $cl, 'path' => $path, 'status' => $this->check($path,'file') ];
            }
            $aData[] = [ 'name' => $key, 'files' => $files, 'filter' => $key.json_encode($files) ];
        }
        echo json_encode($aData);
        exit;
    }
    
    public function aTplBlocks()
    {
        $aData = [];
        $cfg = oxRegistry::getConfig();
        foreach(oxDb::getDb(oxDb::FETCH_MODE_ASSOC)->getAll("SELECT * FROM oxtplblocks") as $val)
        {
            $sModule = $val['OXMODULE'];
            $r = $this->check($val, 'block');
            $val['STATUS'] = $r[0];
            $val['FILEPATH'] =  str_replace($cfg->getConfigParam("sShopDir"),"",$r[1]);
            if(!array_key_exists($sModule, $aData)) $aData[$sModule] = ['name'=>$sModule,'blocks' => [], 'filter' => ''];
            $aData[$sModule]['blocks'][] = $val;
            $aData[$sModule]['filter'] .= json_encode($val);
        }
        echo json_encode(array_values($aData));
        exit;
    }

    public function aModulePaths()
    {
        $oVC = $this->getViewConfig();
        $aData = [];
        foreach(oxRegistry::getConfig()->getConfigParam("aModulePaths") as $key => $val)
        {
            $aData[] = [
                'name' => $key,
                //'active' => $oVC->isModuleActive($key),
                'path' => $val,
                'status' => $this->check($path,'path')
            ];
        }
        echo json_encode($aData);
        exit;
    }

    public function aModuleVersions()
    {
        $cfg = oxRegistry::getConfig();
        echo json_encode($cfg->getConfigParam("aModuleVersions"));
        exit;
    }

    public function aModuleEvents()
    {
        $cfg = oxRegistry::getConfig();
        echo json_encode($cfg->getConfigParam("aModuleEvents"));
        exit;
    }



}
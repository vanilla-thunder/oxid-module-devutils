<?php
/**
 * vt dev utilities - logs
 * The MIT License (MIT)
 *
 * Copyright (C) 2017  Marat Bedoev
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

$sMetadataVersion = '2.0';
$aModule = [
   'id'          => 'dev-logs',
   'title'       => '[devutils] logs',
   'description' => 'logs parser for oxid eshop.<br/>add this code to your config.inc.php to save webserver errors into log/error.log<br><textarea cols="80" rows="3">ini_set(\'error_reporting\',24567); 
ini_set(\'log_errors\',1);
ini_set(\'error_log\',dirname(__FILE__).\'/log/error.log\');</textarea><hr/>access token for chrome extension: '.md5($_SERVER["DOCUMENT_ROOT"]),
   'thumbnail'   => 'oxid-vt.jpg',
   'version'     => '1.3.0',
   'author'      => 'Marat Bedoev',
   'email'       => 'm@marat.ws',
   'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
   'extend'      => [
      \OxidEsales\Eshop\Application\Controller\StartController::class => 
         Vt\Oxid\DevLogs\Controller\StartController::class
   ],
   'controllers' => [
      'vtdev_logs' => Vt\Oxid\DevLogs\Controller\Admin\Logs::class
   ],
   'templates'   => [
      'vtdev_logs.tpl' => 'vt-devutils/dev-logs/views/admin/vtdev_logs.tpl'
   ],
   'settings'    => [
      [
         'group'    => 'vtDev',
         'name'     => 's_vtDev_serverLogPath',
         'type'     => 'str',
         'position' => 0,
         'value'    => 'log/error.log'
      ]
   ]
];

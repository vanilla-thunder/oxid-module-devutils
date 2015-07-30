<?php
include(dirname(__FILE__)."/../vendormetadata.php");

/**
 * vt dev utilities - logs
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

$sMetadataVersion = '1.1';
$aModule = array(
    'id'          => 'dev-logs',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">dev</strong> logs',
    'description' => 'logs parser for oxid eshop.<br/>add this code to your config.inc.php to save webserver errors into log/error.log<br>'.
                     '<input style="width:90%;" type="text" value="ini_set(\'error_log\',dirname(__FILE__).\'/log/error.log\');">'.
                     '<hr/><b style="display: inline-block; float:left;">newest version:</b><img src="' . $newest . '" style=" float:left;"/> (no need to update if you already have this version)',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => $current,
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => array(),
    'files'       => array( 'vtdev_logs' => 'vt-devutils/dev-logs/application/controllers/admin/vtdev_logs.php' ),
    'templates'   => array( 'vt_dev_logs.tpl' => 'vt-devutils/dev-logs/application/views/admin/vt_dev_logs.tpl' ),
    'settings'    => array(
        array(
            'group'    => 'vtDev',
            'name'     => 's_vtDev_serverLogPath',
            'type'     => 'str',
            'position' => 0,
            'value'    => 'log/error.log'
        )
    )
);

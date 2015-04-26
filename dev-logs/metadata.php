<?php

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
 * Version:    0.9
 * Author:     Marat Bedoev <oxid@marat.ws>
 */

$v = "";
$sMetadataVersion = '1.1';
$aModule = array(
    'id'          => 'dev-logs',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">VT dev</strong> logs',
    'description' => 'logs parser for oxid eshop',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '0.9 (2015-03-19)',
    'author'      => 'Marat Bedoev',
    'email'       => 'oxid@marat.ws',
    'url'         => 'http://marat.ws',
    'extend'      => array(),
    'files'       => array( 'vtdev_logs' => 'vt-devutils/dev-logs/application/controllers/admin/vtdev_logs.php' ),
    'templates'   => array( 'vt_dev_logs.tpl' => 'vt-devutils/dev-logs/application/views/admin/vt_dev_logs.tpl' ),
    'settings'    => array(
        array(
            'group'    => 'vtdev_main',
            'name'     => 'vt_dev_logs_sWebserverLog',
            'type'     => 'str',
            'position' => 0,
            'value'    => 'log/error.log'
        )
    )
);
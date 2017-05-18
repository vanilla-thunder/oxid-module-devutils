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
 * Author:     Marat Bedoev <oxid@marat.ws>
 */

$sMetadataVersion = '1.1';
$aModule = [
    'id'          => 'dev-checkout',
    'title'       => '[devutils] checkout (work in progress)',
    'description' => 'show cached module metadata from database and resetting metadata entries',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '0.0.1 (2017-05-15)',
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => [],
    'files'       => [
        //'vtdev_metadata'       => 'vt-devutils/dev-modules/application/controllers/admin/vtdev_metadata.php',
        //'vtdevmodule_metadata' => 'vt-devutils/dev-modules/application/controllers/admin/vtdevmodule_metadata.php'
    ],
    'templates'   => [
        //'vt_dev_metadata.tpl'        => 'vt-devutils/dev-modules/application/views/admin/vt_dev_metadata.tpl',
        //'vt_dev_module_metadata.tpl' => 'vt-devutils/dev-modules/application/views/admin/vt_dev_module_metadata.tpl'
    ],
    'settings'    => []
];
<?php
include(dirname(__FILE__) . "/../vendormetadata.php");

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

$v = 'https://raw.githubusercontent.com/vanilla-thunder/vt-devutils/master/version.jpg';
$sMetadataVersion = '1.1';
$aModule = [
   'id'          => 'dev-metadata',
   'title'       => '[devutils] module metadata',
   'description' => 'show cached module metadata from database and resetting metadata entries',
   'thumbnail'   => '../oxid-vt.jpg',
   'version'     => '1.0.0 (2017-05-17)',
   'author'      => 'Marat Bedoev',
   'email'       => 'm@marat.ws',
   'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
   'extend'      => [],
   'files'       => [
      'vtdev_metadata'       => 'vt-devutils/dev-metadata/application/controllers/admin/vtdev_metadata.php',
      'vtdevmodule_metadata' => 'vt-devutils/dev-metadata/application/controllers/admin/vtdevmodule_metadata.php'
   ],
   'templates'   => [
      'vtdev_metadata.tpl'        => 'vt-devutils/dev-metadata/application/views/admin/vtdev_metadata.tpl',
      'vtdevmodule_metadata.tpl' => 'vt-devutils/dev-metadata/application/views/admin/vtdevmodule_metadata.tpl'
   ],
   'settings'    => []
];
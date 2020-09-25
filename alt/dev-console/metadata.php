<?php
include(dirname(__FILE__) . "/../vendormetadata.php");

/**
 * vt dev utilities - php console
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
$aModule = [
   'id'          => 'dev-console',
   'title'       => '[devutils] console',
   'description' => 'php console for oxid eshop, grants full access to oxid framework for quck testing purposes',
   'thumbnail'   => '../oxid-vt.jpg',
   'version'     => '1.0.0 (2017-05-17)',
   'author'      => 'Marat Bedoev',
   'email'       => 'm@marat.ws',
   'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
   'extend'      => [],
   'files'       => ['vtdev_console' => 'vt-devutils/dev-console/application/controllers/admin/vtdev_console.php'],
   'templates'   => ['vtdev_console.tpl' => 'vt-devutils/dev-console/application/views/admin/vtdev_console.tpl']
];
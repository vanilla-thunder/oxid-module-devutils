<?php

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

$v = 'https://raw.githubusercontent.com/vanilla-thunder/vt-devutils/master/version.jpg';
$sMetadataVersion = '1.1';
$aModule = array(
    'id'          => 'dev-console',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">dev</strong> php console',
    'description' => 'php console for oxid eshop, grants full access to oxid framework for quck testing purposes<hr/><b style="display: inline-block; float:left;">newest version:</b><img src="' . $v . '" style=" float:left;"/> (no need to update if you already have this version)',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '<img src="../modules/vt-devutils/version.jpg"/>',
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => array(),
    'files'       => array( 'vtdev_console' => 'vt-devutils/dev-console/application/controllers/admin/vtdev_console.php' ),
    'templates'   => array( 'vt_dev_console.tpl' => 'vt-devutils/dev-console/application/views/admin/vt_dev_console.tpl' )
);
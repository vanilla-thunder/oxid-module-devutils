<?php

/**
 * vt dev utilities - core
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
 * Version:    1.0.0
 * Author:     Marat Bedoev <m@marat.ws>
 */

$v = 'https://raw.githubusercontent.com/vanilla-thunder/vt-devutils/master/version.jpg';
$sMetadataVersion = '1.1';
$aModule = array(
    'id'          => '_dev-core',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb; padding: 0 2px;background:white;">dev</strong> <b>core</b>',
    'description' => '[vt] developent utilities core package. It is required for all other dev modules from vt-devutils package.<hr/><b style="display: inline-block; float:left;">newest version:</b><img src="' . $v . '" style=" float:left;"/> (no need to update if you already have this version)',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '<img src="../modules/vt-devutils/version.jpg"/>',
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => array(),
    'files'       => array(
        'devuils' => 'vt-devutils/_dev-core/application/models/devuils.php'
    ),
    'events'      => array(),
    'templates'   => array(
        'vt_dev_header.tpl'  => 'vt-devutils/_dev-core/application/views/admin/vt_dev_header.tpl',
        'vt_dev_footer.tpl'  => 'vt-devutils/_dev-core/application/views/admin/vt_dev_footer.tpl',
        'vt_dev_angular_stuff.tpl'=> 'vt-devutils/_dev-core/application/views/admin/vt_dev_angular_stuff.tpl'
        
    ),
    'blocks'      => array(),
    'settings'    => array()
);
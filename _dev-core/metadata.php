<?php
include(dirname(__FILE__)."/../vendormetadata.php");

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
 * Author:     Marat Bedoev <m@marat.ws>
 */

$sMetadataVersion = '1.1';
$aModule = array(
    'id'          => '_dev-core',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb; padding: 0 2px;background:white;">dev</strong> <b>core</b>',
    'description' => '[vt] developent utilities core package. It is required for all other dev modules from vt-devutils package.<hr/><b style="display: inline-block; float:left;">newest version:</b><img src="' . $newest . '" style=" float:left;"/> (no need to update if you already have this version)',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => $current,
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => array(
        'oxutils' => 'vt-devutils/_dev-core/extend/vt_dev_oxutils',
        'oxutilsview' => 'vt-devutils/_dev-core/extend/vt_dev_oxutilsview',
        'oxviewconfig' => 'vt-devutils/_dev-core/extend/vt_dev_oxviewconfig'   
    ),
    'files'       => array(
        'devutils'       => 'vt-devutils/_dev-core/application/models/devutils.php',
        'vt_dev_options' => 'vt-devutils/_dev-core/application/controllers/admin/vt_dev_options.php'
    ),
    'events'      => array(),
    'templates'   => array(
        'vt_dev_header.tpl'  => 'vt-devutils/_dev-core/application/views/admin/vt_dev_header.tpl',
        'vt_dev_footer.tpl'  => 'vt-devutils/_dev-core/application/views/admin/vt_dev_footer.tpl',
        'vt_dev_options.tpl' => 'vt-devutils/_dev-core/application/views/admin/vt_dev_options.tpl'
        
    ),
    'blocks'      => array(
        array(
            'template' => 'bottomnaviitem.tpl',
            'block'    => 'admin_bottomnaviitem',
            'file'     => '/application/views/admin/blocks/bottomnaviitem_admin_bottomnaviitem.tpl'
        )
    ),
    'settings'    => array(
        array('group' => 'vtDevCache', 'name' => 'bl_VtDev_disableLangCache', 'type' => 'bool',  'value' => true),
        array('group' => 'vtDevCache', 'name' => 'bl_VtDev_disableSmartyCache', 'type' => 'bool',  'value' => true)
    )
);
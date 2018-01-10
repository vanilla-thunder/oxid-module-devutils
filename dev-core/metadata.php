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
 * Author:     Marat Bedoev <m@marat.ws>
 */

$sMetadataVersion = '1.1';
$aModule = [
   'id'          => 'dev-core',
   'title'       => '[devutils] _core',
   'description' => '[vt] developent utilities core package. It is <b>required</b> for all other dev modules from vt-devutils package.',
   'thumbnail'   => '../oxid-vt.jpg',
   'version'     => '1.6.0',
   'author'      => 'Marat Bedoev',
   'email'       => 'm@marat.ws',
   'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
   'extend'      => [
      'navigation'  => 'vt-devutils/dev-core/application/extend/navigationVtDev',
      'oxutils'      => 'vt-devutils/dev-core/application/extend/oxutilsVtDev',
      'oxutilsview'  => 'vt-devutils/dev-core/application/extend/oxutilsviewVtDev',
      'oxviewconfig' => 'vt-devutils/dev-core/application/extend/oxviewconfigVtDev'
   ],
   'files'       => [
      'vtdev_gui'  => 'vt-devutils/dev-core/application/controllers/admin/vtdev_gui.php',
      'vtdevutils' => 'vt-devutils/dev-core/application/core/vtdevutils.php'
   ],
   'events'      => [],
   'templates'   => [
      '_vtdev_header.tpl'           => 'vt-devutils/dev-core/application/views/admin/_vtdev_header.tpl',
      '_vtdev_footer.tpl'           => 'vt-devutils/dev-core/application/views/admin/_vtdev_footer.tpl',
      'vtdev_navigation_header.tpl' => 'vt-devutils/dev-core/application/views/admin/vtdev_navigation_header.tpl',
      'vtdev_gui.tpl'               => 'vt-devutils/dev-core/application/views/admin/vtdev_gui.tpl',

   ],
   'blocks'      => [],
   'settings'    => [
      ['group' => 'vtDevCache', 'name' => 'bl_VtDev_disableLangCache', 'type' => 'bool', 'value' => false],
      ['group' => 'vtDevCache', 'name' => 'bl_VtDev_disableSmartyCache', 'type' => 'bool', 'value' => false]
   ]
];

<?php

/**
 * vt dev utilities - mails
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
    'id'          => 'dev-mails',
    'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">VT dev</strong> mails',
    'description' => 'easy mail debugging for oxid eshop',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '0.9 (2015-04-11)',
    'author'      => 'Marat Bedoev',
    'email'       => 'oxid@marat.ws',
    'url'         => 'http://marat.ws',
    'extend'      => array(
            'oxemail' => 'vt-devutils/dev-mails/extend/vt_dev_mail_oxemail',
            'oxorder' => 'vt-devutils/dev-mails/extend/vt_dev_mail_oxorder'
        ),
    'files'       => array(
            'vtdev_mails' => 'vt-devutils/dev-mails/application/controllers/admin/vtdev_mails.php'
        ),
    'templates'   => array(
            'vt_dev_mails.tpl' => 'vt-devutils/dev-mails/application/views/admin/vt_dev_mails.tpl',
            'vt_dev_mails_preview.tpl' => 'vt-devutils/dev-mails/application/views/admin/vt_dev_mails_preview.tpl'
        ),
    'settings'    => array()
);
<?php

/**
 * vt dev utilities - mails
 * The MIT License (MIT]
 *
 * Copyright (C] 2015  Marat Bedoev
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"], to deal
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

$sMetadataVersion = '2.0';
$aModule = [
    'id'          => 'dev-mails',
    'title'       => '[devutils] email preview',
    'description' => 'easy design and debugging for oxid eshop email templates',
    'thumbnail'   => 'oxid-vt.jpg',
    'version'     => '1.3.0',
    'author'      => 'Marat Bedoev',
    'email'       => 'm@marat.ws',
    'url'         => 'https://github.com/vanilla-thunder/vt-devutils',
    'extend'      => [
        \OxidEsales\Eshop\Core\Email::class => 
            Vt\Oxid\DevMails\Core\Email::class,
        \OxidEsales\Eshop\Application\Model\Order::class => 
            Vt\Oxid\DevMails\Model\Order::class
    ],
    'controllers' => [
        'vtdev_mails' => Vt\Oxid\DevMails\Controller\Mails::class
    ],
    'templates' => [
        'vtdev_mails.tpl' => 'vt-devutils/dev-mails/views/vtdev_mails.tpl'
    ],
];
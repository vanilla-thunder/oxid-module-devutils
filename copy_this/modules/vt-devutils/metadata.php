<?php
	/**
	 * vt Dev Utils
	 * Copyright (C) 2012-2013  Marat Bedoev
	 *
	 * This program is free software;
	 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
	 * either version 3 of the License, or (at your option) any later version.
	 *
	 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
	 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
	 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
	 *
	 * Version:    2.0
	 * Author:     Marat Bedoev <oxid@marat.ws>
	 */

	$sMetadataVersion = '1.1';
	$aModule = array(
		'id'          => 'vt-devutils',
		'title'       => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">VT</strong> Dev Utils',
		'description' => 'some helpful functions for OXID developing',
		'thumbnail'   => 'oxid-vt.jpg',
		'version'     => '2.1 from 2013-16-07 / newest version: <img src="https://raw.github.com/vanilla-thunder/vt-devutils/module/version.jpg" style="float:right;"/><br/>
		 <a style="display: inline-block; padding: 1px 15px; background: #f0f0f0; border: 1px solid gray" href="https://github.com/vanilla-thunder/vt-devutils/" target="_blank">info</a> <a style="display: inline-block; padding: 1px 15px; background: #f0f0f0; border: 1px solid gray" href="https://github.com/vanilla-thunder/vt-devutils/archive/master.zip">download</a>',
		'author'      => 'Marat Bedoev',
		'email'       => 'oxid@marat.ws',
		'url'         => 'http://marat.ws',
		'extend'      => array(
			/* core + models */
			'oxviewconfig'  => 'vt-devutils/extend/oxviewconfig_vtdu',
			'oxmodule'      => 'vt-devutils/extend/oxmodule_vtdu',

			/* backend */
			'module_main'   => 'vt-devutils/extend/module_main_vtdu',
			'navigation'    => 'vt-devutils/extend/navigation_vtdu',

			/* frontend */
			'thankyou'      => 'vt-devutils/extend/thankyou_vtdu',
		),
		'files'       => array(
            'vtdu_events'     => 'vt-devutils/files/vtdu_events.php', // module events

			'vtdu_logs'       => 'vt-devutils/files/vtdu_logs.php',     // logs controller
			'vtdu_scratchpad' => 'vt-devutils/files/vtdu_scratchpad.php',   // php scratchpad

			'vtdu'            => 'vt-devutils/files/vtdu.php', // dev utils self
			'vtdu_fe'         => 'vt-devutils/files/vtdu_fe.php', // frontend files
			'vtdu_be'         => 'vt-devutils/files/vtdu_be.php', // backend files
		),
		'templates'   => array(
			'navigation_vtdu.tpl' => 'vt-devutils/views/admin/navigation_vtdu.tpl',

			'vtdu_logs.tpl'       => 'vt-devutils/views/admin/vtdu_logs.tpl',
			'vtdu_scratchpad.tpl' => 'vt-devutils/views/admin/vtdu_scratchpad.tpl',

			'vtdu_ajax.tpl'       => 'vt-devutils/views/vtdu_ajax.tpl',
			'vtdu_fe.tpl'         => 'vt-devutils/views/vtdu_fe.tpl',
			'vtdu_be.tpl'         => 'vt-devutils/views/admin/vtdu_be.tpl',
		),
		'blocks'      => array(
			array('template' => 'headitem.tpl', 'block' => 'admin_headitem_inccss', 'file' => '/views/blocks/admin_headitem_inccss.tpl'),
			//array('template' => 'bottomnaviitem.tpl', 	'block' => 'admin_bottomnaviitem', 	 'file' => '/blocks/admin_bottomnaviitem.tpl'),
			array('template' => 'bottomnaviitem.tpl', 'block' => 'admin_bottomnavicustom', 'file' => '/views/blocks/admin_bottomnavicustom.tpl'),
			array('template' => 'layout/base.tpl', 'block' => 'base_js', 'file' => '/views/blocks/base_js.tpl'),

		),
		'settings'    => array(
			/* debug settings */
			array('group' => 'vtduDebug', 'name' => 'bShowCl', 'type' => 'bool', 'position' => 1, 'value' => true),
			array('group' => 'vtduDebug', 'name' => 'bShowTpl', 'type' => 'bool', 'position' => 2, 'value' => true),
			array('group' => 'vtduDebug', 'name' => 'bKeepBasket', 'type' => 'bool', 'position' => 3, 'value' => true),
			// logs
			array('group' => 'vtduExLog', 'name' => 'bExLog', 'type' => 'bool', 'position' => 1, 'value' => true),
			array('group' => 'vtduExLog', 'name' => 'iExLog', 'type' => 'str',  'position' => 2, 'value' => '5'),
			array('group' => 'vtduSrvErrLog', 'name' => 'bSrvErrLog', 'type' => 'bool', 'position' => 3, 'value' => true),
			array('group' => 'vtduSrvErrLog', 'name' => 'sSrvErrLog', 'type' => 'str',  'position' => 4, 'value' => '/var/log/error.log'),
			array('group' => 'vtduSrvErrLog', 'name' => 'iSrvErrLog', 'type' => 'str',  'position' => 5, 'value' => '5'),
			array('group' => 'vtduSQLLog',  'name' => 'bSqlLog', 'type' => 'bool', 'position' => 6, 'value' => false),
			array('group' => 'vtduSQLLog',  'name' => 'sSqlLog', 'type' => 'str',  'position' => 7, 'value' => '/var/log/mysql.log'),
			array('group' => 'vtduSQLLog',  'name' => 'iSqlLog', 'type' => 'str',  'position' => 8, 'value' => '10'),
			array('group' => 'vtduMailLog', 'name' => 'bMailLog', 'type' => 'bool', 'position' => 9, 'value' => false),
			array('group' => 'vtduMailLog', 'name' => 'sMailLog', 'type' => 'str',  'position' => 10, 'value' => '/var/log/mails'),
			array('group' => 'vtduMailLog', 'name' => 'iMailLog', 'type' => 'str',  'position' => 11, 'value' => '10'),
		)
	);
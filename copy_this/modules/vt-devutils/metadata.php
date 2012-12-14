<?php

/**
 * vt Dev Utils
 * Copyright (C) 2012  Marat Bedoev
 * 
 * This program is free software;
 * you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation;
 * either version 3 of the License, or (at your option) any later version.
 * 
 * This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY;
 * without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License along with this program; if not, see <http://www.gnu.org/licenses/>
 */
$aModule = array(
	 'id' => 'vt-devutils',
	 'title' => '<strong style="color:#c700bb;border: 1px solid #c700bb;padding: 0 2px;background:white;">VT</strong> Dev Utils',
	 'description' => 'some helpful functions for OXID developing:
			<ul><li>clearing tmp folder</li><li>resetting template, blocks, settings and file records for modules</li></ul><hr/>
			<h2>Installation:</h2>edit <strong>out/admin/header.tpl</strong> and append this code the the <strong>&lt;ul&gt;</strong> list:<br/>
			<textarea cols="80" rows="7"><li class="sep">
<a href="[{$oViewConf->getSelfLink()}]&cl=navigation&amp;item=header.tpl&amp;fnc=cleartmp" id="cleartmplink" target="header" class="rc"><b>clear tmp</b></a>
</li>
[{if $cleartmpmsg}]<li class="sep"><a id="deletedfilesmsg" class="rc" style="color:#FF3600"><b>[{$cleartmpmsg}]</b></a></li>[{/if}]</textarea>',
	 'thumbnail' => 'oxid-vt.jpg',
	 'version' => '1.0',
    'author' => 'Marat Bedoev',
    'email' => 'oxid@marat-bedoev.net',
    'url' => 'https://github.com/vanilla-thunder/',
	 'extend' => array(
		  'navigation' => 'vt-devutils/navigation_vtdu',
		  'module_config' => 'vt-devutils/module_config_vtdu',
		  'oxmodule' => 'vt-devutils/oxmodule_vtdu'
	 ),
    'files' => array(
        'vtdu_scratchpad' => 'vt-devutils/admin/vtdu_scratchpad.php'
    ),
    'templates' => array(
        'vtdu_scratchpad.tpl' => 'vt-devutils/out/tpl/vtdu_scratchpad.tpl'
    ),
	 'blocks' => array(
		  array('template' => 'bottomnaviitem.tpl', 'block' => 'admin_bottomnavicustom', 'file' => 'admin_bottomnavicustom.tpl')
	 )
);
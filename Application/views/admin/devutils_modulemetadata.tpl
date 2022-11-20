[{include file="devutils__header.tpl"}]
[{if 1 > 2 }]
    <link rel="stylesheet" type="text/css" href="../../../out/css/materialize.min.css">
    <link rel="stylesheet" type="text/css" href="../../../out/css/devutils.css">
[{/if}]

<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{$oView->getEditObjectId()}]">
    <input type="hidden" name="cl" value="vtdevmodule_metadata">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

[{assign var="oModule" value=$oView->getModule() }]
[{assign var="oMetadataConf" value=$oView->getMetadataConfiguration() }]
[{assign var="oYamlConf" value=$oView->getYamlConfiguration() }]
[{assign var="oDbConf" value=$oView->getDbConfiguration() }]

<div class="row">
    <div class="col s12 l8">
        <div class="card blue-grey darken-1">
            <div class="card-content white-text">
                <span class="card-title">Muss die Konfiguration  aktualisiert werden?</span>
                <form name="myedit" id="myedit" action="[{$oViewConf->getSelfLink()}]" method="post">
                    <div class="input-field py+">
                        <input type="text" value='vendor/bin/oe-console oe:module:install-configuration source/modules/[{$oModule->getModulePath($oView->getEditObjectId())}]'/>
                    </div>
                    [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="cl" value="devmodulemetadata">
                    <input type="hidden" name="oxid" value="[{$oModule->getId()}]">
                    [{* <input type="hidden" name="path" value='source/modules/[{$oModule->getModulePath($oView->getEditObjectId())}]'> *}]
                    <button class="btn waves-effect waves-light" type="submit" name="fnc" value="reinstallModule">
                        reinstall
                        <i class="material-icons right">cached</i>
                    </button>
                </form>
            </div>
        </div>
    </div>
</div>

<table class="striped">
    <colgroup>
        <col width="32%">
        <col width="2%">
        <col width="32%">
        <col width="2%">
        <col width="32%">
    </colgroup>
    <thead>
    </thead>
    <tbody>
    <tr>
        <th class="p-"><h4 class="p- m-">metadata.php</h4></th>
        <th></th>
        <th class="p-"><h4 class="p- m-">yaml</h4></th>
        <th></th>
        <th class="p-"><h4 class="p- m-">database</h4></th>
    </tr>
    <tr>
        <td class="p-">
            [{if is_array($oMetadataConf.title)}]
                [{foreach from=$oMetadataConf.title key="_lang" item="_title"}]
                    <div><b>[{$_lang}]:</b> [{$_title}]</div>
                [{/foreach}]
            [{else}]
                <div>[{$oMetadataConf.title}]</div>
            [{/if}]
            <hr/>
            <div>version [{$oMetadataConf.version}]</div><hr/>
            [{* <div>source/modules/[{$oMetadataConf.path}]</div><hr/> *}]
            [{if is_array($oMetadataConf.description)}]
                [{foreach from=$oMetadataConf.description key="_lang" item="_desc"}]
                    <div><b>[{$_lang}]:</b> [{$_desc}]</div>
                [{/foreach}]
            [{else}]
                <div>[{$oMetadataConf.description}]</div>
            [{/if}]
        </td>
        <td class="p-"></td>
        <td class="p- [{* if $oYamlConf->getTitle()|@reset !== $oMetadataConf.title || $oYamlConf->getVersion() !== $oMetadataConf.version || $oYamlConf->getDescription()|@reset !== $oMetadataConf.description}]red lighten-5[{/if *}]">
            [{foreach from=$oYamlConf->getTitle() key="_lang" item="_title"}]
                <div><b>[{$_lang}]:</b> [{$_title}]</div>
            [{/foreach}]
            <hr/>
            <div [{if $oYamlConf->getVersion() !== $oMetadataConf.version}]class="red-text"[{/if}]>
                version [{$oYamlConf->getVersion()}]
            </div><hr/>
            [{* <div [{if $oYamlConf->getPath() !== $oMetadataConf.path}]class="red-text"[{/if}]>source/modules/[{$oYamlConf->getPath()}]</div><hr/> *}]
            [{foreach from=$oYamlConf->getDescription() key="_lang" item="_desc"}]
                <div><b>[{$_lang}]:</b> [{$_desc}]</div>
            [{/foreach}]
        </td>
        <td class="p-"></td>
        <td class="p- [{if $oDbConf.version !== $oMetadataConf.version}]red lighten-5[{/if}]">
            <div><i>Title is not cached</i></div><hr/>
            <div [{if $oDbConf.version !== $oMetadataConf.version}]class="red-text"[{/if}]>version [{$oDbConf.version}]</div><hr/>
            [{* <div [{if $oDbConf.path !== $oMetadataConf.path}]class="red-text"[{/if}]>source/modules/[{$oDbConf.path}]</div><hr/> *}]
            <div><i>Description is not cached</i></div>
        </td>
    </tr>

    [{*
    <tr><th colspan="5" class="divider"><h4>events</h4></th></tr>
    <tr>
        <td>
            [{if !$oMetadataConf.events|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oMetadataConf.events key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getEvents()|@count !== $oMetadataConf.events|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getEvents()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getEvents() item="_item"}]
                <b>[{$_item->getAction()}]</b><div>[{$_item->getMethod()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.events|@count !== $oMetadataConf.events|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.events|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.events key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>extensions</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.extend name="data" key="_key" item="_item"}]
                <b>[{$_key}]</b><div><small>[{$_item}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getClassExtensions()|@count !== $oMetadataConf.extend|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oYamlConf->getClassExtensions() name="data" item="_item"}]
                <b>[{$_item->getShopClassName()}]</b><div><small>[{$_item->getModuleExtensionClassName()}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.extend|@count !== $oMetadataConf.extend|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.extend|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.extend name="data" key="_key" item="_item"}]
                <b>[{$_key}]</b><div><small>[{$_item}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>controllers</h4></th></tr>
    <tr>
        <td>
            [{if !$oMetadataConf.controllers}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oMetadataConf.controllers name="data" key="_key" item="_item"}]
                <b>[{$_key}]</b><div><small>[{$_item}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getControllers() && $oYamlConf->getControllers()|@count !== $oMetadataConf.controllers|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getControllers()}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getControllers() name="data" item="_item"}]
                <b>[{$_item->getId()}]</b><div><getControllerssmall>[{$_item->getControllerClassNameSpace()}]</getControllerssmall></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.controllers|@count !== $oMetadataConf.controllers|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.controllers}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.controllers name="data" key="_key" item="_item"}]
                <b>[{$_key}]</b><div><small>[{$_item}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
    </tr>
    *}]

    [{assign var="tplok" value="DEVUTILS_TPL_OK"|oxmultilangassign}]
    [{assign var="tplnf" value="DEVUTILS_TPL_NF"|oxmultilangassign}]

    <tr><th colspan="5" class="divider"><h4>templates</h4></th></tr>
    [{assign var="aMetadataTplFiles" value=$oMetadataConf.templates|@array_column:"file"}]
    <tr>
        <td>
            [{foreach from=$oMetadataConf.templates name="data" key="_key" item="_item"}]
                <div [{if !array_key_exists($_key,$oDbConf.templates)
                        || !in_array($_item.file,$oDbConf.templates)}]class="green lighten-5"[{/if}]>

                    <b>[{$_key}]</b> [{if $_item.check}][{$tplok}][{else}][{$tplnf}][{/if}]
                    <div><small>[{$_item.file}]</small></div>
                    [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
                </div>
            [{/foreach}]
        </td>
        <td></td>
        <td>
            [{if $oYamlConf->getTemplates()|@count !== $oMetadataConf.templates|@count}]
                <div class="orange-text">
                    <h4>⚠ <small>amount of templates is different from metadata.php</small></h4>
                </div>
                <hr/>
            [{/if}]
            [{if !$oYamlConf->getTemplates()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]

            [{foreach from=$oYamlConf->getTemplates() name="data" item="_item"}]
                <div [{if !array_key_exists($_item->getTemplateKey(),$oMetadataConf.templates)
                        || !in_array($_item->getTemplatePath(),$aMetadataTplFiles)}]class="red lighten-5"[{/if}]>

                    <b [{if !array_key_exists($_item->getTemplateKey(),$oMetadataConf.templates)}]class="red-text"[{/if}]>
                        [{$_item->getTemplateKey()}]
                    </b>
                    <div [{if !in_array($_item->getTemplatePath(),$aMetadataTplFiles)}]class="red-text"[{/if}]>
                        <small>[{$_item->getTemplatePath()}]</small>
                    </div>
                    [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
                </div>
            [{/foreach}]
        </td>
        <td></td>
        <td>
            [{if $oDbConf.templates|@count !== $oMetadataConf.templates|@count}]
                <div class="orange-text">
                    <h4>⚠ <small>amount of templates is different from metadata.php</small></h4>
                </div>
                <hr/>
            [{/if}]
            [{if !$oDbConf.templates|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]

            [{foreach from=$oDbConf.templates name="data" key="_key" item="_item"}]
                <div [{if !array_key_exists($_key,$oMetadataConf.templates)
                        || !in_array($_item,$aMetadataTplFiles)}]class="red lighten-5"[{/if}]>

                    <b [{if !array_key_exists($_key,$oMetadataConf.templates)}]class="red-text"[{/if}]>
                        [{$_key}]
                    </b>
                    <div [{if !in_array($_item,$aMetadataTplFiles)}]class="red-text"[{/if}]>
                        <small>[{$_item}]</small>
                    </div>
                    [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
                </div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>tpl blocks</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.blocks name="data" key="_key" item="_item"}]
                <div class="[{if !$oDbConf.blocks[$_key]}]green-text[{/if}]">
                    <b>[{$_key}]</b> [{if $_item.check}][{$tplok}][{else}][{$tplnf}][{/if}]
                    <div><small>[template] [{$_item.template}]</small></div>
                    <div><small>[file] [{$_item.file}]</small></div>
                </div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getTemplateBlocks() && $oYamlConf->getTemplateBlocks()|@count !== $oMetadataConf.blocks|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getTemplateBlocks()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getTemplateBlocks() name="data" item="_item"}]
                <b>[{$_item->getBlockName()}]</b> - pos [{$_item->getPosition()}] / theme [{$_item->getTheme()|default:"*"}]
                <div><small>[template] [{$_item->getShopTemplatePath()}]</small></div>
                <div><small>[file] [{$_item->getModuleTemplatePath()}]</small></div>

                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
                [{* <b>[{$_item->getShopClassName()}]</b><div>[{$_item->getModuleExtensionClassName()}]</div> *}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.blocks|@count !== $oMetadataConf.blocks|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oDbConf.blocks name="data" key="_key" item="_item"}]
                <b>[{$_key}]</b> - pos [{$_item.OXPOS}] / theme [{$_item.OXTHEME|default:"*"}]
                <div><small>[template] [{$_item.OXTEMPLATE}]</small></div>
                <div><small>[file] [{$_item.OXFILE}]</small></div>
                [{if !$smarty.foreach.data.last}]<hr/>[{/if}]
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>settings</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.settings item="_item"}]
                <div><b>[{$_item.name}]</b> ([{$_item.type}]) [{* : [{$_item.value|@var_export *}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getModuleSettings() && $oYamlConf->getModuleSettings()|@count !== $oMetadataConf.settings|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getModuleSettings()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getModuleSettings() item="_item"}]
                <div><b>[{$_item->getName()}]</b> ([{$_item->getType()}])</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.settings|@count !== $oMetadataConf.settings|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oDbConf.settings name="data" key="_key" item="_item"}]
                <div class="[{if !$oMetadataConf.settings[$_key]}]red-text[{/if}]">
                    <b>[{$_item.OXVARNAME}]</b> ([{$_item.OXVARTYPE}])
                </div>
            [{/foreach}]
        </td>
    </tr>
[{*
    <tr><th colspan="5" class="divider"><h4>smarty plugin directories</h4></th></tr>
    <tr>
        <td>
            [{if !$oMetadataConf.smartyPluginDirectories|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oMetadataConf.smartyPluginDirectories name="data" key="_key" item="_item"}]
                <div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getSmartyPluginDirectories() && $oYamlConf->getSmartyPluginDirectories()|@count !== $oMetadataConf.smartyPluginDirectories|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getSmartyPluginDirectories()}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getSmartyPluginDirectories() item="_item"}]
                <div>[{$_item->getDirectory()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td></td>
    </tr>
*}]

    </tbody>
</table>


[{include file="devutils__footer.tpl"}]

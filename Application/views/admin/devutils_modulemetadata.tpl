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
                        <input type="text" value='vendor/bin/oe-console oe:module:install-configuration source/modules/[{$oModule->getModulePath($oView->getEditObjectId())}]''/>
                    </div>
                    [{$oViewConf->getHiddenSid()}]
                    <input type="hidden" name="cl" value="devmodulemetadata">
                    <input type="hidden" name="oxid" value="[{$oModule->getId()}]">
                    <button class="btn waves-effect waves-light" type="submit" name="fnc" value="reinstallModule">
                        reload
                        <i class="material-icons right">cached</i>
                    </button>
                    <button class="btn waves-effect waves-light" type="submit" name="fnc" value="reactivateModule">
                        restart
                        <i class="material-icons right">call_missed_outgoing</i>
                    </button>
                    (man muss wahrscheinlich beides machen)
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
    <tr>
        <th><h4>metadata.php</h4><!---[{$oMetadataConf|@var_dump}]--></th>
        <th></th>
        <th><h4>yaml</h4><!--[{$oYamlConf|@var_dump}]--></th>
        <th></th>
        <th><h4>database</h4><!--[{$oDbConf|@var_dump}]--></th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td class="p-">
            version [{$oMetadataConf.version}]<br/>
            [{$oMetadataConf.path}]
        </td>
        <td class="p-"></td>
        <td class="p- [{if $oYamlConf->getVersion() !== $oMetadataConf.version}]red-text[{/if}]">
            version [{$oYamlConf->getVersion()}]<br/>
            [{$oYamlConf->getPath()}]
        </td>
        <td class="p-"></td>
        <td class="p-">
            version [{$oDbConf.version}]<br/>
            [{$oDbConf.path}]
        </td>
    </tr>
    <tr>
        <td>[{$oMetadataConf.title}]<br/>[{$oMetadataConf.description}]</td>
        <td></td>
        <td>[{$oYamlConf->getTitle()|@reset}]<br/>[{$oYamlConf->getDescription()|@reset}]</td>
        <td></td>
        <td>no module data is cached</td>
    </tr>

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
            [{foreach from=$oMetadataConf.extend key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getClassExtensions()|@count !== $oMetadataConf.extend|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oYamlConf->getClassExtensions() item="_item"}]
                <b>[{$_item->getShopClassName()}]</b><div>[{$_item->getModuleExtensionClassName()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.extend|@count !== $oMetadataConf.extend|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.extend|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.extend key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>controllers</h4></th></tr>
    <tr>
        <td>
            [{if !$oMetadataConf.controllers|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oMetadataConf.controllers key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getControllers()|@count !== $oMetadataConf.controllers|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getControllers()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getControllers() item="_item"}]
                <b>[{$_item->getId()}]</b><div>[{$_item->getControllerClassNameSpace()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.controllers|@count !== $oMetadataConf.controllers|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.controllers|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.controllers key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>templates</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.templates key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getTemplates()|@count !== $oMetadataConf.templates|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getTemplates()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getTemplates() item="_item"}]
                <b>[{$_item->getTemplateKey()}]</b><div>[{$_item->getTemplatePath()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.templates|@count !== $oMetadataConf.templates|@count}]class="red lighten-5"[{/if}]>
            [{if !$oDbConf.templates|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oDbConf.templates key="_key" item="_item"}]
                <b>[{$_key}]</b><div>[{$_item}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>tpl blocks</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.blocks key="_key" item="_item"}]
                <b>[{$_key}]</b>
                <div>[template] => [{$_item.template}]</div>
                <div>[file] => [{$_item.file}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getTemplateBlocks()|@count !== $oMetadataConf.blocks|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getTemplateBlocks()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getTemplateBlocks() item="_item"}]
                <b>[{$_item->getBlockName()}]</b> - pos [{$_item->getPosition()}] / theme [{$_item->getTheme()|default:"*"}]
                <div>[template] => [{$_item->getShopTemplatePath()}]</div>
                <div>[file] => [{$_item->getModuleTemplatePath()}]</div>

                [{* <b>[{$_item->getShopClassName()}]</b><div>[{$_item->getModuleExtensionClassName()}]</div> *}]
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.blocks|@count !== $oMetadataConf.blocks|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oDbConf.blocks key="_key" item="_item"}]
                <b>[{$_key}]</b> - pos [{$_item.OXPOS}] / theme [{$_item.OXTHEME|default:"*"}]
                <div>[template] => [{$_item.OXTEMPLATE}]</div>
                <div>[file] => [{$_item.OXFILE}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>settings</h4></th></tr>
    <tr>
        <td>
            [{foreach from=$oMetadataConf.settings key="_key" item="_item"}]
                <div><b>[{$_item.name}]</b> ([{$_item.type}]): [{$_item.value|@var_dump}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getModuleSettings()|@count !== $oMetadataConf.settings|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getModuleSettings()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getModuleSettings() item="_item"}]
                <div><b>[{$_item->getName()}]</b> ([{$_item->getType()}]): [{$_item->getValue()|@var_dump}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oDbConf.settings|@count !== $oMetadataConf.settings|@count}]class="red lighten-5"[{/if}]>
            [{foreach from=$oDbConf.settings key="_key" item="_item"}]
                <div><b>[{$_item.OXVARNAME}]</b> ([{$_item.OXVARTYPE}]): [{$_item.OXVARVALUE|@var_dump}]</div>
            [{/foreach}]
        </td>
    </tr>

    <tr><th colspan="5" class="divider"><h4>smarty plugin directories</h4></th></tr>
    <tr>
        <td>
            [{if !$oMetadataConf.smartyPluginDirectories|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oMetadataConf.smartyPluginDirectories key="_key" item="_item"}]
                <div>[{$_item}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td [{if $oYamlConf->getSmartyPluginDirectories()|@count !== $oMetadataConf.smartyPluginDirectories|@count}]class="red lighten-5"[{/if}]>
            [{if !$oYamlConf->getSmartyPluginDirectories()|@count}][{oxmultilang ident="DEVUTILS_NO_ENTRIES"}][{/if}]
            [{foreach from=$oYamlConf->getSmartyPluginDirectories() item="_item"}]
                <div>[{$_item->getDirectory()}]</div>
            [{/foreach}]
        </td>
        <td></td>
        <td></td>
    </tr>


    </tbody>
</table>


[{include file="devutils__footer.tpl"}]

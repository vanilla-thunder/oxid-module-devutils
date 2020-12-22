[{include file="devutils__header.tpl"}]

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
                    <p>
                    <div class="input-field">
                        <input type="text" value='vendor/bin/oe-console oe:module:install-configuration source/modules/[{$oModule->getModulePath($oView->getEditObjectId())}]''/>
                    </div>
                    </p>
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
        <th>
            metadata.php version
            <span [{if $oMetadataConf.version != $oView->getModuleVersion($oView->getEditObjectId())}]class="green-text"[{/if}]>[{$oMetadataConf.version}]</span>
        </th>
        <th></th>
        <th>
            yaml version
            <span [{if $oMetadataConf.version != $oView->getModuleVersion($oView->getEditObjectId())}]class="green-text"[{/if}]>[{$oMetadataConf.version}]</span>
        </th>
        <th></th>
        <th>
            db version
            <span [{if $aModule.version != $oView->getModuleVersion($oView->getEditObjectId())}]class="red-text"[{/if}]>[{$oView->getModuleVersion($oView->getEditObjectId())}]</span>
        </th>
    </tr>
    </thead>
    <tbody>

    [{* extensions *}]
    [{assign var="aDbExtensions" value=$oModule->getExtensions()}]
    [{assign var="aYamlbExtensions" value=$oYamlConfiguration->getClassExtensions()}]
    [{if $aExtensions || $aModule.extend}]
        <tr>
            <th colspan="3" class="[{if $aModule.extend == $aExtensions}]green[{else}]red[{/if}]-text">extensions</th>
        </tr>
        <tr>
            <td>
                [{foreach from=$aModule.extend key="key" item="val"}]
                    <b [{if !$aExtensions.$key}]class="green-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aExtensions.$key || $val != $aExtensions.$key}]class="green-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
            <td></td>
            <td>
                [{foreach from=$aExtensions key="key" item="val"}]
                    <b [{if !$aModule.extend.$key}]class="red-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aModule.extend.$key || $val != $aModule.extend.$key}]class="red-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
        </tr>
    [{/if}]

    [{* controllers *}]
    [{assign var="aControllers" value=$oModule->getControllers()}]
    [{if $aControllers || $aModule.controllers}]
        <tr>
            <th colspan="3" class="[{if $aModule.controllers == $aControllers}]green[{else}]red[{/if}]-text center-align"><h4 class="mv0">controllers</h4></th>
        </tr>
        <tr>
            <td>
                [{foreach from=$aModule.controllers key="key" item="val"}]
                    <b [{if !$aControllers.$key}]class="green-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aControllers.$key || $val != $aControllers.$key}]class="green-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
            <td></td>
            <td>
                [{foreach from=$oModule->getControllers() key="key" item="val"}]
                    <b [{if !$aModule.controllers.$key}]class="red-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aModule.controllers.$key || $val != $aModule.controllers.$key}]class="red-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
        </tr>
    [{/if}]

    [{* files *}]
    [{assign var="aFiles" value=$oModule->getFiles()}]
    [{if $aFiles || $aModule.files}]
        <tr>
            <th colspan="3" class="[{if $aModule.files == $aFiles}]green[{else}]red[{/if}]-text">files</th>
        </tr>
        <tr>
            <td>
                [{foreach from=$aModule.files key="key" item="val"}]
                    <b [{if !$aFiles.$key}]class="green-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aFiles.$key || $val != $aFiles.$key}]class="green-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
            <td></td>
            <td>
                [{foreach from=$aFiles key="key" item="val"}]
                    <b [{if !$aModule.files.$key}]class="red-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aModule.files.$key || $val != $aModule.files.$key}]class="red-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
        </tr>
    [{/if}]

    [{* templates *}]
    [{assign var="aTemplates" value=$oModule->getInfo("templates")}]
    [{if $aTemplates || $aModule.templates}]
        <tr>
            <th colspan="3" class="[{if $aModule.templates == $aTemplates}]green[{else}]red[{/if}]-text">templates</th>
        </tr>
        <tr>
            <td>
                [{foreach from=$aModule.templates key="key" item="val"}]
                    <b [{if !$aTemplates.$key}]class="green-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aTemplates.$key || $val != $aTemplates.$key}]class="green-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
            <td></td>
            <td>
                [{foreach from=$aTemplates key="key" item="val"}]
                    <b [{if !$aModule.templates.$key}]class="red-text"[{/if}]>[{$key}]</b>
                    <div [{if !$aModule.templates.$key || $val != $aModule.templates.$key}]class="red-text"[{/if}]>[{$val}]</div>
                [{/foreach}]
            </td>
        </tr>
    [{/if}]

    [{* blocks *}]
    [{assign var="aBlocks" value=$oView->getModuleBlocks()}]
    [{if $aBlocks || $aModule.blocks }]
        <tr>
            <th colspan="3" [{* class="[{if $aModule.blocks == $aBlocks}]green[{else}]red[{/if}]-text"*}]>blocks (wörk in progress)</th>
        </tr>
        <tr>
            <td>
                <table class="striped">
                    <thead>
                    <tr>
                        <th>theme</th>
                        <th>template</th>
                        <th>block</th>
                        <th>pos</th>
                    </tr>
                    </thead>
                    <tbody>
                    [{foreach from=$aModule.blocks item="block"}]
                        <tr>
                            <td>[{$block.theme|default:"*"}]</td>
                            <td>[{$block.template}]</td>
                            <td>[{$block.block}]</td>
                            <td>[{$block.OXPOS}]</td>
                        </tr>
                        <tr>
                            <td colspan="4">[{$block.file}]</td>
                        </tr>
                    [{/foreach}]
                    </tbody>
                </table>
            </td>
            <td></td>
            <td>
                <table class="striped">
                    <thead>
                    <tr>
                        <th>theme</th>
                        <th>template</th>
                        <th>block</th>
                        <th>pos</th>
                    </tr>
                    </thead>
                    <tbody>
                    [{foreach from=$aBlocks item="block"}]
                        <tr>
                            <td>[{$block.OXTHEME|default:"*"}]</td>
                            <td>[{$block.OXTEMPLATE}]</td>
                            <td>[{$block.OXBLOCKNAME}]</td>
                            <td>[{$block.OXPOS}]</td>
                        </tr>
                        <tr>
                            <td colspan="4">[{$block.OXFILE}]</td>
                        </tr>
                    [{/foreach}]
                    </tbody>
                </table>
            </td>
        </tr>
    [{/if}]

    [{* settings *}]
    [{assign var="aSettings" value=$oView->getModuleSettings()}]
    [{if $aSettings || $aModule.settings }]
        <tr>
            <th colspan="3">
                settings
                [{if $aModule.settings == $aSettings}]
                    <i class="material-icons tiny green-text">check</i>
                [{else}]
                    [{assign var="unequal" value=true}]
                    <i class="material-icons tiny red-text">close</i>
                [{/if}]
            </th>
        </tr>
        <tr>
            <td>
                [{foreach from=$aModule.settings key="name" item="type"}]
                    <div>
                        [{$name}]
                        <span>([{$type}])</span>
                    </div>
                [{/foreach}]
            </td>
            <td></td>
            <td>
                [{foreach from=$aSettings key="name" item="type"}]
                    <div [{if !$aModule.settings.$name}]class="red-text"[{/if}]>
                        [{$name}]
                        <span [{if $type != $aModule.settings.$name}]class="red-text"[{/if}]>([{$type}])</span>
                    </div>
                [{/foreach}]
            </td>
        </tr>
    [{/if}]
    </tbody>
</table>



[{include file="devutils__footer.tpl"}]

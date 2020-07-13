[{include file="devutils__header.tpl"}]


<div class="row pt">
    <div class="col s12">
        <ul id="metadatatabs" class="tabs">
            <li class="tab col"><a class="active" href="#amodules">all extensions</a></li>
            <li class="tab col"><a href="#amoduleextensions">module extensions</a></li>
            <li class="tab col"><a href="#amodulecontrollers">controllers</a></li>
            <li class="tab col"><a href="#amoduletemplates">templates</a></li>
            <li class="tab col"><a href="#atplblocks">tpl blocks</a></li>
        </ul>
    </div>
    <div id="amodules" class="col s12">
        [{* aModules *}]
        <ul>
            <li ng-repeat="(_cl,_ext) in aModules.value track by $index" class="mv+">
                <b ng-bind="_cl"></b>
                <ul class="pl+">
                    <li ng-repeat="_e in _ext track by $index" ng-bind="_e"></li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="amoduleextensions" class="col s12">
        <ul>
            <li ng-repeat="(_module,_extensions) in aModuleExtensions.value track by $index" class="mv+">
                <b ng-bind="_module"></b>
                <ul class="pl+">
                    <li ng-repeat="_extension in _extensions track by $index">
                        <span ng-bind="_extension.class"></span>
                        <i ng-if="_extension.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                        <i ng-if="_extension.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="amodulecontrollers" class="col s12">
        <ul>
            <li ng-repeat="(_module,_controllers) in aModuleControllers.value track by $index" class="mv+">
                <b ng-bind="_module"></b>
                <table class="striped ml+ mt">
                    <tr ng-repeat="_controller in _controllers track by $index">
                        <td ng-bind="_controller.class"></td>
                        <td>
                            <span ng-bind="_controller.path"></span>
                            <i ng-if="_controller.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                            <i ng-if="_controller.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
    <div id="amoduletemplates" class="col s12">
        <ul>
            <li ng-repeat="(_module,_templates) in aModuleTemplates.value track by $index" class="mv+">
                <b ng-bind="_module"></b>
                <ul class="pl+">
                    <li ng-repeat="_tpl in _templates track by $index" class="mt">
                        <b ng-bind="_tpl.file + ' >> '"></b>
                        <span ng-bind="_tpl.path"></span>
                        <i ng-if="_tpl.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                        <i ng-if="_tpl.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                        <div>full path: {{_tpl.fullpath}}</div>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="atplblocks" class="col s12">
        <h5 ng-if="aTplBlocks.value.length == 0">there are no template blocks available</h5>
        <div ng-if="aTplBlocks.value.length > 0" ng-repeat="(_module,_blocks) in aTplBlocksc track by $index" class="card">
            <div class="card-content">
                <span class="card-title" ng-bind="_module"></span>
                <ul>
                    <li ng-repeat="_block in _blocks track by $index" class="mt row">
                        <div class="col s2 m1 center-align">

                            <div class="switch mt">
                                <span class="pb" ng-if="_block.OXACTIVE">ON</span>
                                <span class="pb" ng-if="!_block.OXACTIVE">OFF</span>
                                <label>
                                    <input type="checkbox" ng-true-value="1" ng-false-value="0" ng-model="_block.OXACTIVE" ng-change="toggleTplBLock(_block)">
                                    <span class="lever"></span>
                                </label>
                            </div>
                        </div>
                        <div class="col s10 m11">
                            <b>{{_block.OXTEMPLATE}} > {{_block.OXBLOCKNAME}} > pos {{_block.OXPOS}}</b><br/>
                            <div ng-bind="_block.OXFILE"></div>
                            <div>
                                <small ng-bind="_block.fullpath"></small>
                                <i ng-if="_block.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                                <i ng-if="_block.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                            </div>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </div>
</div>

<!--
<lx-tabs>

    [{*
        <lx-tab lx-label="extensions">

            <div class="container px++">
                <div class="toolbar my+" flex-container="row">
                    <div flex-item="2">
                        <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load(aModules)"><i class="mdi mdi-refresh"></i> reload</button>
                    </div>
                    <div flex-item="">
                        <lx-search-filter><input type="text" ng-model="search.aModules" placeholder="search..."></lx-search-filter>
                    </div>
                </div>


                <table class="data-table">
                    <thead>
                    <colgroup>
                        <col width="50%"/>
                        <col width="50%"/>
                    </colgroup>
                    </thead>
                    <tbody>
                    <tr class="" ng-repeat="item in aModules.content">
                        <td align="right" valign="top"><h2 ng-bind-html="item.label  |highlight:search.aModules |html"></h2></td>
                        <td>
                            <ul class="list">
                                <li class="list-row" ng-repeat="subitem in item.items">
                                    <div class="list-row__primary">
                                        <i ng-if="subitem.status == 1" lx-tooltip="extension file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                                        <i ng-if="subitem.status == -1" lx-tooltip="extension file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                                    </div>
                                    <div class="list-row__content"><span ng-bind-html="subitem.file |highlight:search.aModules |html"></span>
                                    </div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                    </tbody>
                </table>
            </div>
        </lx-tab>
    *}]
        [{* aModuleControllers *}]
    <lx-tab lx-label="controllers">

        <div class="container px++">
            <div class="toolbar my+" flex-container="row">
                <div flex-item="2">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load(aModuleControllers)"><i class="mdi mdi-refresh"></i> reload</button>
                </div>
                <div flex-item="">
                    <lx-search-filter><input type="text" ng-model="search.aModuleControllers" placeholder="search..."></lx-search-filter>
                </div>
            </div>

            <table class="data-table">
                <thead>
                <colgroup>
                    <col width="40%"/>
                    <col width="60%"/>
                </colgroup>
                </thead>
                <tbody>
                <tr class="" ng-repeat="item in aModuleFiles.content |filter:{filter:search.aModuleFiles}:false">
                    <td align="right" valign="top"><h2 ng-bind-html="item.label  |highlight:search.aModuleFiles |html"></h2></td>
                    <td>
                        <ul class="list">
                            <li class="list-row" ng-repeat="subitem in item.items">
                                <div class="list-row__primary">
                                    <i ng-if="subitem.status == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                                    <i ng-if="subitem.status == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                                </div>
                                <div class="list-row__content">
                                    <strong ng-bind-html="subitem.file |highlight:search.aModuleFiles |html"></strong>
                                    <span class="" ng-bind-html="subitem.path |highlight:search.aModuleFiles |html"></span>
                                </div>
                            </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>

        </div>
    </lx-tab>

    [{* aModuleTemplates *}]
    <lx-tab lx-label="templates">
        <div class="card">
            <div class="container toolbar" flex-container="row">
                <div flex-item="1">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModuleTemplates )"><i class="mdi mdi-refresh"></i> refresh</button>
                </div>
                <div flex-item="4">
                    <lx-search-filter><input type="text" ng-model="search.aModuleTemplates" placeholder="search..."></lx-search-filter>
                </div>
            </div>
        </div>

        <div class="container card mt+">
            <table class="data-table">
                <thead>
                <colgroup>
                    <col width="40%"/>
                    <col width="60%"/>
                </colgroup>
                </thead>
                <tbody>
                <tr class="" ng-repeat="item in aModuleTemplates.content |filter:{filter:search.aModuleTemplates}:false">
                    <td align="right" valign="top"><h2 ng-bind-html="item.label  |highlight:search.aModuleTemplates |html"></h2></td>
                    <td>
                        <ul class="list">
                            <li class="list-row" ng-repeat="subitem in item.items">
                                <div class="list-row__primary">
                                    <i ng-if="subitem.status == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                                    <i ng-if="subitem.status == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                                </div>
                                <div class="list-row__content">
                                    <strong ng-bind-html="subitem.file |highlight:search.aModuleTemplates |html"></strong>
                                    <span class="" ng-bind-html="subitem.path |highlight:search.aModuleTemplates |html"></span>
                                </div>
                            </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </lx-tab>

    [{* aTplBLocks *}]
    <lx-tab lx-label="tpl blocks">
        <div class="card">
            <div class="container toolbar" flex-container="row">
                <div flex-item="1">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aTplBlocks )"><i class="mdi mdi-refresh"></i> refresh</button>
                </div>
                <div flex-item="4">
                    <lx-search-filter><input type="text" ng-model="search.aTplBlocks" placeholder="search..."></lx-search-filter>
                </div>
            </div>
        </div>

        <div class="container card mt+">
            <table class="data-table">
                <thead>
                <colgroup>
                    <col width="40%"/>
                    <col width="60%"/>
                </colgroup>
                </thead>
                <tbody>
                <tr class="" ng-repeat="item in aTplBlocks.content |filter:{filter:search.aTplBlocks}:false">
                    <td align="right" valign="top"><h2 ng-bind-html="item.label |highlight:search.aTplBlocks |html"></h2></td>
                    <td>
                        <ul class="list">
                            <li class="list-row" ng-repeat="subitem in item.items">
                                <div class="list-row__primary">
                                    <i ng-if="subitem.OXACTIVE == 1" ng-click="toggleTplBLock(subitem.OXID);" lx-tooltip="block active" class="icon icon--s icon--green icon--flat mdi mdi-power"></i>
                                    <i ng-if="subitem.OXACTIVE == 0" ng-click="toggleTplBLock(subitem.OXID);" lx-tooltip="block inactive" class="icon icon--s icon--red icon--flat mdi mdi-power"></i>

                                    <i ng-if="subitem.STATUS == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                                    <i ng-if="subitem.STATUS == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                                </div>
                                <div class="list-row__content">
                                    <h3 ng-bind-html="subitem.OXTEMPLATE |highlight:search.aTplBlocks |html"></h3>
                                    <h3 ng-bind-html="subitem.OXBLOCKNAME |highlight:search.aTplBlocks |html"></h3>
                                    <strong ng-bind-html="subitem.OXFILE |highlight:search.aTplBlocks |html"></strong>
                                    <span class="display-block fs-body-1 tc-black-2" ng-bind-html="subitem.FILEPATH |highlight:search.aTplBlocks |html"></span>
                                </div>
                            </li>
                        </ul>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>
    </lx-tab>

    [{* paths, events *}]
    <lx-tab lx-label="paths & events">
        <div class="card">
            <div class="container toolbar" flex-container="row">
                <div flex-item="1">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModuleTemplates )"><i class="mdi mdi-refresh"></i> refresh</button>
                </div>
                <div flex-item="4">
                    <lx-search-filter><input type="text" ng-model="search.aModuleEvents" placeholder="search..."></lx-search-filter>
                </div>
            </div>
        </div>

        <div class="container" flex-container="row">
            <div class="card m+ p+" flex-item="">
                <strong class="fs-headline display-block">module paths</strong>
                <hr/>
                <ul class="list">
                    <li class="list-row list-row--has-separator" ng-repeat="mod in aModulePaths.content |filter:{filter:search.aModuleEvents}:false">
                        <div class="list-row__primary">
                            [{*
                            <i ng-if="mod.active == 1" lx-tooltip="module active" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                            <i ng-if="mod.active == 0" lx-tooltip="module inactive" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                            *}]
                            <i ng-if="mod.status == 1" lx-tooltip="path found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                            <i ng-if="mod.status == -1" lx-tooltip="path not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                        </div>
                        <div class="list-row__content">
                            <strong ng-bind-html="mod.name |highlight:search.aModuleTemplates |html"></strong>
                            <span class="small" ng-bind-html="mod.path |highlight:search.aModuleTemplates |html"></span>
                        </div>
                    </li>
                </ul>
            </div>

            <div class="card m+ p+" flex-item="">
                <strong class="fs-headline display-block">events</strong>
                <hr/>
                <ul class="list mt++">
                    <li class="list-subheader" ng-repeat-start="(key, val) in aModuleEvents.content"><h3>{{ key }}</h3></li>
                    <li class="list-row" ng-repeat="(cl, path) in val">{{ cl }} - {{ path }}</li>
                    <li class="list-divider" ng-repeat-end></li>
                </ul>
            </div>
        </div>
    </lx-tab>
</lx-tabs>
-->
<script>
    [{capture assign="ng"}]

    $scope.search = {};

    $scope.aModules = {
        title: "modules",
        fnc: "getModules",
        value: []
    };
    $scope.aModuleExtensions = {
        title: "extensions",
        fnc: "getModuleExtensions",
        value: []
    };
    $scope.aModuleControllers = {
        title: "controllers",
        fnc: "getModuleControllers",
        value: []
    };
    $scope.aModuleTemplates = {
        title: "templates",
        fnc: "getModuleTemplates",
        value: []
    };
    $scope.aTplBlocks = {
        title: "blocks",
        fnc: "getTplBlocks",
        value: [],
        templates: []
    };
    $scope.aModulePaths = {
        title: "module paths",
        fnc: "getModulePaths",
        value: []
    };

    $scope.createTemplatesFilter = function (data)
    {
        $scope.aTplBlocks.templates = [];
        data.forEach(function (element, index, array)
        {
            element.blocks.forEach(function (element, index, array)
            {
                if ($scope.aTplBlocks.templates.indexOf(element.OXTEMPLATE) == -1) $scope.aTplBlocks.templates.push(element.OXTEMPLATE);
            });
        });
    };

    $scope.load = function (data)
    {
        $http.get('[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devmetadata"|replace:"&amp;":"&" }]&fnc=' + data.fnc)
             .then(function (res)
             {
                 data.value = res.data;

                 //if (data.label == 'blocks') $scope.createTemplatesFilter(res.data);
                 //LxNotificationService.success(data.label + ' loaded');
             });
    }
    ;

    $scope.toggleTplBLock = function (_block)
    {
        $http.get('[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devmetadata"|replace:"&amp;":"&" }]&fnc=toggleTplBlock&block=' + _block.OXID)
             .then(function (res)
             {
                 //console.log(res);
                 if (res.data == "ok") M.toast({html: _block.OXMODULE+' '+_block.OXBLOCKNAME+' '+(_block.OXACTIVE > 0 ? "en" : "dis" )+"abled"});
                 else  M.toast({html: "this did not work, you should check your logs and oxtplblocks table"});
             });
    };

    $scope.load($scope.aModules);
    $scope.load($scope.aModuleExtensions);
    $scope.load($scope.aModuleControllers);
    $scope.load($scope.aModuleTemplates);
    $scope.load($scope.aTplBlocks);
    //$scope.load($scope.aModulePaths);
    setTimeout(function ()
    {
        $(".tabs").tabs();
        $('.tooltipped').tooltip();
    }, 500);
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
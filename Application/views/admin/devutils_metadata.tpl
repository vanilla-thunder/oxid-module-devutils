[{include file="devutils__header.tpl"}]


<div class="row pt">
    <div class="col s12">
        <ul id="metadatatabs" class="tabs">
            <li class="tab col"><a class="active" href="#amodules">extensions</a></li>
            <li class="tab col"><a href="#amoduleextensions">extensions per module</a></li>
            <li class="tab col"><a href="#amodulecontrollers">controllers</a></li>
            <li class="tab col"><a href="#amoduletemplates">templates</a></li>
            <li class="tab col"><a href="#atplblocks">tpl blocks</a></li>
            <li class="tab col"><a href="#blocksorting">block sorting</a></li>
        </ul>
    </div>
    <div id="amodules" class="col s12">
        <div class="input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="search" ng-model="search.amodules" autocomplete="off"></div>
        <ul>
            <li ng-repeat="(_cl,_ext) in aModules.value track by $index" ng-show="(_ext |filter:search.amodules:false).length > 0" class="mv+">
                <h5 ng-bind="_cl"></h5>
                <ul class="pl+">
                    <li ng-repeat="_e in _ext |filter:search.amodules:false track by $index" ng-bind-html="_e| highlight:search.amodules | html"></li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="amoduleextensions" class="col s12">
        <div class="input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="search" ng-model="search.amoduleextensions" autocomplete="off"></div>
        <ul>
            <li ng-repeat="(_module,_extensions) in aModuleExtensions.value track by $index" ng-show="(_extensions | filter:search.amoduleextensions:false).length > 0" class="mv+">
                <h5 ng-bind="_module"></h5>
                <ul class="pl+">
                    <li ng-repeat="_extension in _extensions | filter:search.amoduleextensions:false track by $index">
                        <span ng-bind-html="_extension.class | highlight:search.amoduleextensions | html"></span>
                        <i ng-if="_extension.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                        <i ng-if="_extension.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                    </li>
                </ul>
            </li>
        </ul>
    </div>
    <div id="amodulecontrollers" class="col s12">
        <div class="input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="search" ng-model="search.amodulecontrollers" autocomplete="off"></div>
        <ul>
            <li ng-repeat="(_module,_controllers) in aModuleControllers.value track by $index" ng-show="(_controllers | filter:{path:search.amodulecontrollers}:false).length > 0" class="mv+">
                <h5 ng-bind="_module"></h5>
                <table class="striped ml+ mt">
                    <tr ng-repeat="_controller in _controllers | filter:{path:search.amodulecontrollers}:false track by $index">
                        <td ng-bind="_controller.class"></td>
                        <td>
                            <span ng-bind-html="_controller.path | highlight:search.amodulecontrollers | html"></span>
                            <i ng-if="_controller.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="class exists" data-position="right">check</i>
                            <i ng-if="_controller.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="class does not exist!" data-position="right">close</i>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
    <div id="amoduletemplates" class="col s12">
        <div class="input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="search" ng-model="search.amoduletemplates" autocomplete="off"></div>
        <ul>
            <li ng-repeat="(_module,_templates) in aModuleTemplates.value track by $index" ng-show="(_templates | filter:{file:search.amoduletemplates}:false).length > 0" class="mv+">
                <h5 ng-bind="_module"></h5>
                <table class="striped ml+ mt">
                    <tr ng-repeat="_tpl in _templates track by $index">
                        <td ng-bind-html="_tpl.file | highlight:search.amoduletemplates | html"></td>
                        <td>
                            <span ng-bind="_tpl.path"></span>
                            <i ng-if="_tpl.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="template found" data-position="right">check</i>
                            <i ng-if="_tpl.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="template not found!" data-position="right">close</i>
                            <i class="material-icons tiny tooltipped" data-tooltip="full path of the file: {{_tpl.fullpath}}" data-position="bottom">search</i>
                        </td>
                    </tr>
                </table>
                [{*<ul class="pl+">
                    <li ng-repeat="_tpl in _templates track by $index" class="mt">
                        <b ng-bind="_tpl.file + ' : '"></b>
                        <span ng-bind-html="_tpl.path | highlight:search.amoduletemplates | html"></span>
                        <i ng-if="_tpl.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="template found" data-position="right">check</i>
                        <i ng-if="_tpl.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="template not found!" data-position="right">close</i>
                        <div class="tooltipped" data-tooltip="full path to the file, where oxid is looking for it according to metadata entry" data-position="top">full path <span ng-bind-html="_tpl.fullpath | highlight:search.amoduletemplates | html"></span></div>
                    </li>
                </ul>*}]
            </li>
        </ul>
    </div>
    <div id="atplblocks" class="col s12">
        <div>
            <div class="col s4 input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="theme" ng-model="search.atplblockstheme" autocomplete="off"></div>
            <div class="col s4 input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="template" ng-model="search.atplblockstemplate" autocomplete="off"></div>
            <div class="col s4 input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="block name" ng-model="search.atplblocksblock" autocomplete="off"></div>
        </div>
        <h5 ng-if="Object.keys(aTplBlocks.value).length == 0">there are no template blocks available</h5>
        <ul>
            <li ng-repeat="(_module,_blocks) in aTplBlocks.value track by $index"
                ng-if="(_blocks | filter:{OXTHEME:search.atplblockstheme}:false | filter:{OXTEMPLATE:search.atplblockstemplate}:false | filter:{OXBLOCKNAME:search.atplblocksblock}:false).length > 0" class="mv+">
                <h5 ng-bind="_module"></h5>
                <table class="striped ml+ mt">
                    <tr ng-repeat="_block in _blocks | filter:{OXTHEME:search.atplblockstheme}:false | filter:{OXTEMPLATE:search.atplblockstemplate}:false | filter:{OXBLOCKNAME:search.atplblocksblock}:false track by $index" ng-if="(_blocks | filter:{OXTHEME:search.atplblockstheme}:false | filter:{OXTEMPLATE:search.atplblockstemplate}:false | filter:{OXBLOCKNAME:search.atplblocksblock}:false).length > 0">
                        <td class="center-align" style="width: 100px;">
                            <span class="pb" ng-if="_block.OXACTIVE">ON</span>
                            <span class="pb" ng-if="!_block.OXACTIVE">OFF</span>
                            <div class="switch mt">
                                <label>
                                    <input type="checkbox" ng-true-value="1" ng-false-value="0" ng-model="_block.OXACTIVE" ng-change="toggleTplBLock(_block)">
                                    <span class="lever"></span>
                                </label>
                            </div>
                        </td>
                        <td>
                            <div><b>theme:</b> <span ng-bind-html="_block.OXTHEME || '*' | highlight:search.atplblockstheme | html"></span></div>
                            <div><b>template:</b> <span ng-bind-html="_block.OXTEMPLATE | highlight:search.atplblockstemplate | html"></span></div>
                            <div><b>block name:</b> <span ng-bind-html="_block.OXBLOCKNAME | highlight:search.atplblocksblock | html"></span> (<b>pos:</b> <span ng-bind="_block.OXPOS"></span>)</div>
                            <div>
                                <b>file: </b>
                                <span ng-bind="_block.OXFILE"></span>&nbsp;
                                <i ng-if="_block.status == 1" class="material-icons tiny green-text tooltipped" data-tooltip="everything seems fine" data-position="right">check</i>
                                <i ng-if="_block.status == -1" class="material-icons tiny red-text tooltipped" data-tooltip="file not found!" data-position="right">close</i>
                            </div>
                            <div ng-bind="_block.fullpath"></div>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
    <div id="blocksorting" class="col s12">
        <div>
            <div class="col s6 input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="template" ng-model="search.atplblocksortingtemplate" autocomplete="off"></div>
            <div class="col s6 input-field"><i class="material-icons prefix">search</i><input type="text" placeholder="block name" ng-model="search.atplblocksortingblock" autocomplete="off"></div>
        </div>
        <ul>
            <li ng-repeat="(_template, _blocknames) in aTplBlockSorting.value track by $index" ng-if="(!search.atplblocksortingtemplate || _template.indexOf(search.atplblocksortingtemplate) >= 0) && (!search.atplblocksortingblock || (Object.keys(_blocknames) | filter:search.atplblocksortingblock:false).length > 0)">
                <h5 ng-bind-html="_template |highlight:search.atplblocksortingtemplate |html"></h5>
                <table class="striped">
                    <tr ng-repeat="(_blockname, _blocks) in _blocknames track by $index" [{* ng-if="search.atplblocksortingblock === '' ||  _blockname.indexOf(search.atplblocksortingblock) >= 0" *}]>
                        <td width="30%" class="right-align pr++" ng-bind-html="_blockname |highlight:search.atplblocksortingblock |html"></td>
                        <td>
                            <ul data-as-sortable="aTplBlockSorting.options" data-ng-model="_blocks" data-tempalte="{{_template}}" data-blockname="{{_blockname}}">
                                <li ng-repeat="_block in _blocks" data-as-sortable-item style="max-width: 600px;" data-oxid="{{_block.OXID}}">
                                    <div data-as-sortable-item-handle class="p">
                                        <div class="row m0">
                                            <div class="col s1"><b ng-bind="$index"></b></div>
                                            <div class="col s2">pos: {{_block.OXPOS}}</div>
                                            <div class="col s5">module: {{_block.OXMODULE}}</div>
                                            <div class="col s4">theme: {{_block.OXTHEME||"*"}}</div>
                                        </div>
                                    </div>
                                </li>
                            </ul>
                        </td>
                    </tr>
                </table>
            </li>
        </ul>
    </div>
</div>
<!--
<lx-tabs>
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
    $scope.aTplBlockSorting = {
        title: "block sorting",
        fnc: "getTplBlockSorting",
        options: {
            orderChanged: function (event) {
                console.log(event.dest.sortableScope.modelValue);
                var _newBlockOrder = [];
                event.dest.sortableScope.modelValue.forEach(function(item, index) {
                    item["OXPOS"] = index;
                    _newBlockOrder.push(item["OXID"]);
                })

                $http.post('[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devmetadata"|replace:"&amp;":"&" }]&fnc=updateBlockOrder',_newBlockOrder)
                    .then(function (res)
                    {
                        console.log(res);
                    });
            }
        },
        value: []
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
    };

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
    $scope.load($scope.aTplBlockSorting);
    //$scope.load($scope.aModulePaths);
    setTimeout(function ()
    {
        $(".tabs").tabs();
        $('.tooltipped').tooltip();
    }, 500);
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
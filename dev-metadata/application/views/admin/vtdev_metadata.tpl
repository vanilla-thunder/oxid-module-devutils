[{include file="_vtdev_header.tpl"}]

<lx-tabs>

   [{* aModules *}]
   <lx-tab lx-label="extensions">
      <div class="card">
         <div class="container toolbar" flex-container="row">
            <div flex-item="1">
               <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModules )"><i class="mdi mdi-refresh"></i> refresh</button>
            </div>
            <div flex-item="4">
               <lx-search-filter><input type="text" ng-model="search.aModules" placeholder="search..."></lx-search-filter>
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
            <tr class="" ng-repeat="item in aModules.content |filter:{filter:search.aModules}:false">
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

   [{* aModuleFiles *}]
   <lx-tab lx-label="files">
      <div class="card">
         <div class="container toolbar" flex-container="row">
            <div flex-item="1">
               <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModuleFiles )"><i class="mdi mdi-refresh"></i> refresh</button>
            </div>
            <div flex-item="4">
               <lx-search-filter><input type="text" ng-model="search.aModuleFiles" placeholder="search..."></lx-search-filter>
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

<script>
   [{capture assign="ng"}]
   $scope.search = {};

   var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_metadata&fnc=xxxxxx"|replace:"&amp;":"&" }]';

   $scope.aModules         = {
       title: "extensions",
       fnc: "aModules",
       content: []
   };
   $scope.aModuleFiles     = {
       title: "files",
       fnc: "aModuleFiles",
       content: []
   };
   $scope.aModulePaths     = {
       title: "module paths",
       fnc: "aModulePaths",
       content: []
   };
   $scope.aModuleVersions  = {
       title: "module versions",
       fnc: "aModuleVersions",
       content: []
   };
   $scope.aModuleEvents    = {
       title: "module events",
       fnc: "aModuleEvents",
       content: []
   };
   $scope.aModuleTemplates = {
       title: "templates",
       fnc: "aModuleTemplates",
       content: []
   };
   $scope.aTplBlocks       = {
       title: "blocks",
       fnc: "aTplBlocks",
       content: [],
       templates: []
   };

   $scope.createTemplatesFilter = function (data) {
       $scope.aTplBlocks.templates = [];
       data.forEach(function (element, index, array) {
           element.blocks.forEach(function (element, index, array) {
               if ($scope.aTplBlocks.templates.indexOf(element.OXTEMPLATE) == -1) $scope.aTplBlocks.templates.push(element.OXTEMPLATE);
           });
       });
   };

   $scope.load = function (data) {
       $http.get(url.replace("xxxxxx", data.fnc)).then(function (res) {
           data.content = res.data;
           //console.log(res.data);
           if (data.label == 'blocks') $scope.createTemplatesFilter(res.data);
           LxNotificationService.success(data.label + ' loaded');
       });
   };

   $scope.toggleTplBLock = function (oxid) {

       $http.get(url.replace("xxxxxx", "toggletplblock") + '&block=' + oxid).then(function (res) {
           if (res.data.msg == "done") {
               LxNotificationService.success('done');
               $scope.load($scope.aTplBlocks);
           }

       });
   };

   $scope.load($scope.aModules);
   $scope.load($scope.aModuleFiles);
   $scope.load($scope.aModuleTemplates);
   $scope.load($scope.aTplBlocks);
   $scope.load($scope.aModulePaths);
   //$scope.load($scope.aModuleVersions);
   $scope.load($scope.aModuleEvents);
   [{/capture}]
</script>

[{include file="_vtdev_footer.tpl"}]
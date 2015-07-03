[{include file="vt_dev_header.tpl"}]
<lx-tabs>
   [{* aModules *}]
   <lx-tab heading="extensions">
      <div class="container card">
      <div class="toolbar" flex-container="row">
         <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModules )"><i class="mdi mdi-refresh"></i> refresh</button></div>
         <div flex-item="4"><lx-search-filter model="search.aModules" filter-width="100%" placeholder="search..."></lx-search-filter></div>
      </div>
      </div>
      
      <div class="container grid-2" masonry='{ "transitionDuration" : "0.4s" , "itemSelector" : ".grid-item"}'>
         <div masonry-tile class="grid-item" ng-repeat="class in aModules.content |filter:{name:search.aModules}:false">
            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block" ng-bind-html="class.name |highlight:search.aModules |html"></strong>
                     <ul class="list mt++">
                        <li class="list-row" ng-repeat="ext in class.extensions">
                           <div class="list-row__primary">
                              <i ng-if="ext.status == 1" lx-tooltip="extension file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                              <i ng-if="ext.status == -1" lx-tooltip="extension file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                           </div>
                           <div class="list-row__content">
                              <span ng-bind-html="ext.file |highlight:search.aModules |html"></span>
                           </div>
                        </li>
                     </ul>
               </div>
            </div>
         </div>
      </div>
   </lx-tab>

   [{* aModuleFiles *}]
   <lx-tab heading="files">
      <div class="container card">
         <div class="toolbar" flex-container="row">
            <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModuleFiles )"><i class="mdi mdi-refresh"></i> refresh</button></div>
            <div flex-item="4"><lx-search-filter model="search.aModuleFiles" filter-width="100%" placeholder="search..."></lx-search-filter></div>
         </div>
      </div>
      <div class="container grid-2" masonry='{ "transitionDuration" : "0.4s" , "itemSelector" : ".grid-item" }'>
         <div masonry-tile class="grid-item" ng-repeat="mod in aModuleFiles.content |filter:{name:search.aModuleFiles}:false">
            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block" ng-bind-html="mod.name |highlight:search.aModuleFiles |html"></strong>
                     <ul class="list mt++">
                        <li class="list-row list-row--has-separator" ng-repeat="item in mod.files">
                           <div class="list-row__primary">
                              <i ng-if="item.status == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                              <i ng-if="item.status == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                           </div>
                           
                           <div class="list-row__content">
                              <strong ng-bind-html="item.file |highlight:search.aModuleFiles |html"></strong>
                              <span class="small" ng-bind-html="item.path |highlight:search.aModuleFiles |html"></span>
                           </div>
                        </li>
                     </ul>
               </div>
            </div>
         </div>
      </div>
   </lx-tab>

   [{* aModuleTemplates *}]
   <lx-tab heading="templates">
      <div class="container card">
         <div class="toolbar" flex-container="row">
            <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aModuleTemplates )"><i class="mdi mdi-refresh"></i> refresh</button></div>
            <div flex-item="4"><lx-search-filter model="search.aModuleTemplates" filter-width="100%" placeholder="search..."></lx-search-filter></div>
         </div>
      </div>
      
      <div class="container grid-2" masonry='{ "transitionDuration" : "0.4s" , "itemSelector" : ".grid-item" }'>
         <div masonry-tile class="grid-item" ng-repeat="mod in aModuleTemplates.content |filter:{name:search.aModuleTemplates}:false">
            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block" ng-bind-html="mod.name |highlight:search.aModuleTemplates |html"></strong>
                     <ul class="list mt++">
                        <li class="list-row list-row--has-separator" ng-repeat="item in mod.files">
                           <div class="list-row__primary">
                              <i ng-if="item.status == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                              <i ng-if="item.status == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                           </div>
                           <div class="list-row__content">
                              <strong ng-bind-html="item.file |highlight:search.aModuleTemplates |html"></strong>
                              <span class="small" ng-bind-html="item.path |highlight:search.aModuleTemplates |html"></span>
                           </div>
                        </li>
                     </ul>
               </div>
            </div>
         </div>
      </div>
   </lx-tab>
   
   [{* aTplBLocks *}]
   <lx-tab heading="tpl blocks">
      <div class="container card">
         <div class="toolbar" flex-container="row">
            <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="load( aTplBlocks )"><i class="mdi mdi-refresh"></i> refresh</button></div>
            <div flex-item="4"><lx-search-filter model="search.aTplBlocks" filter-width="100%" placeholder="search..."></lx-search-filter></div>
         </div>
      </div>
      
      <div class="container grid-2" masonry='{ "transitionDuration" : "0.4s" , "itemSelector" : ".grid-item" }'>
         <div masonry-tile class="grid-item" ng-repeat="mod in aTplBlocks.content |filter:{filter:search.aTplBlocks}:false">
            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block" ng-bind-html="mod.name |highlight:search.aTplBlocks |html"></strong>
                     <ul class="list mt++">
                        <li class="list-row list-row--has-separator" ng-repeat="block in mod.blocks">
                           <div class="list-row__primary">
                              <i ng-if="block.STATUS == 1" lx-tooltip="file found" class="icon icon--s icon--green icon--flat mdi mdi-checkbox-marked-circle-outline"></i>
                              <i ng-if="block.STATUS == -1" lx-tooltip="file not found" class="icon icon--s icon--red icon--flat mdi mdi-close-circle-outline"></i>
                           </div>
                           <div class="list-row__content">
                              <strong ng-bind-html="block.OXFILE |highlight:search.aTplBlocks |html"></strong>
                              <span class="small" ng-bind-html="block.FILEPATH |highlight:search.aTplBlocks |html"></span>
                           </div>
                        </li>
                     </ul>
               </div>
            </div>
         </div>
      </div>
   </lx-tab>

   [{* paths, events *}]
   <lx-tab heading="paths & events">
      <div class="container" flex-container="row">
         <div flex-item flex-container="column">

            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block">module paths</strong>
                  <hr/>
                  <ul class="list mt++">
                     <li class="list-row list-row--has-separator" ng-repeat="mod in aModulePaths.content">
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
            </div>

         </div>
         <div flex-item flex-container="column">

            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block">events</strong>
                  <hr/>
                  <ul class="list mt++">
                     <li class="list-subheader" ng-repeat-start="(key, val) in aModuleEvents.content"><h3>{{ key }}</h3></li>
                     <li class="list-row" ng-repeat="(cl, path) in val">{{ cl }} - {{ path }}</li>
                     <li class="list-divider" ng-repeat-end></li>
                  </ul>
               </div>
            </div>

         </div>
      </div>
   </lx-tab>
</lx-tabs>


[{* http://img-9gag-fun.9cache.com/photo/a2YQ31p_460sv.mp4 *}]

<script>
   [{capture assign="ng"}]
   var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_metadata&fnc=xxxxxx"|replace:"&amp;":"&" }]';

   $scope.aModules = {
      title: "extensions",
      fnc: "aModules",
      content: []
   };
   $scope.aModuleFiles = {
      title: "files",
      fnc: "aModuleFiles",
      content: []
   };

   $scope.aModulePaths = {
      title: "module paths",
      fnc: "aModulePaths",
      content: []
   };
   $scope.aModuleVersions = {
      title: "module versions",
      fnc: "aModuleVersions",
      content: []
   };
   $scope.aModuleEvents = {
      title: "module events",
      fnc: "aModuleEvents",
      content: []
   };

   $scope.aModuleTemplates = {
      title: "templates",
      fnc: "aModuleTemplates",
      content: []
   };
   $scope.aTplBlocks = {
      title: "blocks",
      fnc: "aTplBlocks",
      content: []
   };

   $scope.load = function (data) {
      $http.get(url.replace("xxxxxx", data.fnc)).then(function (res) {
         data.content = res.data;
         console.log(res.data);
         LxNotificationService.success(data.title + ' loaded');
      });
   };

   $scope.load($scope.aModules);
   $scope.load($scope.aModuleFiles);
   $scope.load($scope.aModuleTemplates);
   $scope.load($scope.aTplBlocks);
   $scope.load($scope.aModulePaths);
   //$scope.load($scope.aModuleVersions);
   $scope.load($scope.aModuleEvents)

   $scope.check = function(file,type) {
      $http({
         method: 'POST',
         url: url.replace("xxxxxx", "check"),
         data: {'file': file, 'type':type},
         headers: {'Content-Type': 'application/json'}
      })
      .success(function (data, status, headers, config) {
         console.log(data);
         if (data.error) alert(data.error);
      })
      .error(function (data, status, headers, config) {
         $scope.output = status+' : '+data.error;
      });
   };

   [{/capture}]
</script>

[{include file="vt_dev_footer.tpl"}]
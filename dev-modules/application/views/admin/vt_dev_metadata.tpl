[{include file="vt_dev_header.tpl"}]
<br/>
<lx-tabs>
   [{* aModules *}]
   <lx-tab heading="extensions">
      <div class="container card">
      <ul class="list mt++">
         <li class="list-subheader" ng-repeat-start="(class, extends) in aModules.content"><h3>{{ class }}</h3></li>
         <li class="list-row" ng-repeat="ext in extends.split('&')">{{ ext }}</li>
         <li class="list-divider" ng-repeat-end></li>
      </ul>
      </div>
   </lx-tab>

   [{* aModuleFiles *}]
   <lx-tab heading="files">
      <div class="container card">
         <ul class="list mt++">
            <li class="list-subheader" ng-repeat-start="(key, val) in aModuleFiles.content"><h3>{{ key }}</h3></li>
            <li class="list-row" ng-repeat="(cl, path) in val">{{ cl }} - {{ path }}</li>
            <li class="list-divider" ng-repeat-end></li>
         </ul>
      </div>
   </lx-tab>

   [{* aModuleTemplates *}]
   <lx-tab heading="templates">
      <div class="container card">
         <ul class="list mt++">
            <li class="list-subheader" ng-repeat-start="(key, val) in aModuleTemplates.content"><h3>{{ key }}</h3></li>
            <li class="list-row" ng-repeat="(cl, path) in val">{{ cl }} - {{ path }}</li>
            <li class="list-divider" ng-repeat-end></li>
         </ul>
      </div>
   </lx-tab>

   [{* versions, paths, events *}]
   <lx-tab heading="paths & events">
      <div class="container" flex-container="row">
         <div flex-item flex-container="column">

            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block">module paths</strong>
                  <hr/>
                  <ul class="list mt++">
                     <li class="list-row" ng-repeat="(key, val) in aModulePaths.content">{{ key }} - {{ val }}</li>
                  </ul>
               </div>
            </div>

         </div>
         <div flex-item flex-container="column">

            <div class="card">
               <div class="p+">
                  <strong class="fs-headline display-block">versions</strong>
                  <hr/>
                  <ul class="list mt++">
                     <li class="list-row" ng-repeat="(key, val) in aModuleVersions.content">{{ key }} - {{ val }}</li>
                  </ul>
               </div>
            </div>

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
   $scope.tplBLocks = {
      title: "blocks",
      fnc: "tplBLocks",
      content: []
   };

   $scope.load = function (data)
   {
      $http.get(url.replace("xxxxxx", data.fnc)).then(function (res) {
         data.content = res.data;
         //console.log(res.data);
         LxNotificationService.success(data.title + ' loaded');
      });
   };

   $scope.load($scope.aModules);;
   $scope.load($scope.aModuleFiles);;
   $scope.load($scope.aModuleTemplates);
   $scope.load($scope.aModulePaths);
   $scope.load($scope.aModuleVersions);
   $scope.load($scope.aModuleEvents)


   [{/capture}]
</script>

[{include file="vt_dev_footer.tpl"}]
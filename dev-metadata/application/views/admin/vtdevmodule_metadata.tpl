[{include file="_vtdev_header.tpl"}]
<form name="transfer" id="transfer" action="[{ $oViewConf->getSelfLink() }]" method="post">
    [{ $oViewConf->getHiddenSid() }]
    <input type="hidden" name="oxid" value="[{$oView->getEditObjectId()}]">
    <input type="hidden" name="cl" value="vtdevmodule_metadata">
    <input type="hidden" name="fnc" value="">
    <input type="hidden" name="actshop" value="[{$oViewConf->getActiveShopId()}]">
    <input type="hidden" name="updatenav" value="">
    <input type="hidden" name="editlanguage" value="[{ $editlanguage }]">
</form>

<div class="container grid-2" masonry='{ "transitionDuration" : "0.4s" , "itemSelector" : ".grid-item" }'>
   
   [{* extensions *}]
   <div masonry-tile class="grid-item"> 
      <div class="card">
         <div class="p+">
            <strong class="fs-headline display-block">extensions</strong>
            <div class="paragraph mt+">
               <ul class="list mt++">
                  [{foreach from=$oModule->getExtensions() key="key" item="val"}]
                     <li class="list-row" >[{$key}] => [{$val}]</li>
                  [{/foreach}]
               </ul>
            </div>
         </div>
      </div>
   </div>

   [{* files *}]
   <div masonry-tile class="grid-item"> 
      <div class="card">
         <div class="p+">
            <strong class="fs-headline display-block">files</strong>
            <div class="paragraph mt+">
               <ul class="list mt++">
                  [{foreach from=$oModule->getFiles() key="key" item="val"}]
                     <li class="list-row" >[{$key}] => [{$val}]</li>
                  [{/foreach}]
               </ul>
            </div>
         </div>
      </div>
   </div>

   [{* templates *}]
   <div masonry-tile class="grid-item"> 
      <div class="card">
         <div class="p+">
            <strong class="fs-headline display-block">templates</strong>
            <div class="paragraph mt+">
               <ul class="list mt++">
                  [{foreach from=$oModule->getTemplates() key="key" item="val"}]
                     <li class="list-row" >[{$key}] => [{$val}]</li>
                  [{/foreach}]
               </ul>
            </div>
         </div>
      </div>
   </div>

   [{* blocks *}]
   <div masonry-tile class="grid-item"> 
      <div class="card">
         <div class="p+">
            <strong class="fs-headline display-block">blocks</strong>
            <div class="paragraph mt+">
               <ul class="list mt++">
                  [{foreach from=$oModule->getInfo("blocks") item="block"}]
                  <li class="list-row list-row--multi-line list-row--has-separator">
                     <div class="list-row__content">
                        <span class="display-block">[{$block.block}]</span>
                        <span class="display-block fs-body-1 tc-black-2">
                           file: [{$block.file}]<br/>
                           template: [{$block.template}]
                        </span>
                     </div>
                  </li>
                  [{/foreach}]
               </ul>
            </div>
         </div>
      </div>
   </div>
   
   
</div>

  


[{* http://img-9gag-fun.9cache.com/photo/a2YQ31p_460sv.mp4 *}]

<script>
   [{capture assign="ng"}]
   var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdevmodule_metadata&fnc=xxxxxx"|replace:"&amp;":"&" }]';

   $scope.aModules = {
      title: "extensions",
      fnc: "getModuleExtensions",
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

   $scope.load = function (data) {
      $http.get(url.replace("xxxxxx", data.fnc)).then(function (res) {
         //data.content = res.data;
         console.log(res);
         LxNotificationService.success(data.title + ' loaded');
      });
   };

   
   /*
   $scope.load($scope.aModuleFiles);
   $scope.load($scope.aModuleTemplates);
   $scope.load($scope.aModulePaths);
   $scope.load($scope.aModuleEvents)
   */


   [{/capture}]
</script>

[{include file="_vtdev_footer.tpl" b2t=false}]

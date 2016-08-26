[{include file="vt_dev_header.tpl"}]

[{if $error}]<h1>[{$error|var_dump}]</h1>[{/if}]

<lx-tabs>
   <lx-tab lx-label="shop exceptions">
      <div class="card">
         <div class="container toolbar" flex-container="row">
            <div flex-item="1">
               <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="loadExceptionLog()"><i class="mdi mdi-refresh"></i> refresh</button>
            </div>
            <div flex-item="4">
               <lx-search-filter><input type="text" ng-model="search.exception" placeholder="search..."></lx-search-filter>
            </div>
         </div>

         <hr/>

         <ul class="list mt++ logs">
            <li class="list-row list-row--has-separator" ng-repeat="log in exceptionlog |filter:{full:search.exception}:false |limitTo:20" ng-click="exception( log )">
               <div class="list-row__content">
                  <div class="h3">{{ $index+1 }} # <span ng-bind-html="log.header |highlight:search.exception |html"></span></div>
                  <span ng-bind-html="log.subheader |highlight:search.exception |html"></span>
               </div>
            </li>
         </ul>
      </div>
   </lx-tab>

   <lx-tab lx-label="webserver errors">
      <div class="card">
         <div class="toolbar container" flex-container="row">
            <div flex-item="1">
               <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="loadErrorLog()"><i class="mdi mdi-refresh"></i> refresh</button>
            </div>
            <div flex-item="4">
               <lx-search-filter><input type="text" ng-model="search.error" placeholder="search..."></lx-search-filter>
            </div>
            <div flex-item="2">
               <lx-text-field lx-label="in..."><input type="text" ng-model="search.errin"></lx-text-field>
            </div>
            <div flex-item="2">
               <lx-text-field lx-label="filter by date..."><input type="text" ng-model="search.errdate"></lx-text-field>
            </div>
            <div flex-item="2">
               <lx-text-field lx-label="filter by client ( [{$ip}] )"><input type="text" ng-model="search.errclient"></lx-text-field>
            </div>
         </div>

         <hr/>

         <ul class="list mt++ logs">
            <li class="list-row list-row--has-separator" ng-repeat="log in errorlog |filter:{full:search.error}:false |filter:{in:search.errin}:false |filter:{client:search.errclient}:false |filter:{date:search.errdate} |limitTo:30">
               <div class="list-row__primary">
                  <i ng-show="log.type=='error'" class="icon icon--l icon--red icon--circled mdi mdi-ambulance"></i>
                  <i ng-show="log.type=='warning'" class="icon icon--l icon--orange icon--circled mdi mdi-sim-alert"></i>
               </div>

               <div class="list-row__content">
                  <div class="h4">{{ $index+1 }} # <span ng-bind-html="log.header |highlight:search.error |html"></span></div>

                  <div class="fs-body-1 tc-black-2">
                     <div flex-container="row">
                        <div flex-item><b>in:</b> <span ng-bind-html="log.in |highlight:search.errin |html"></span></div>
                        <div ng-bind-html="log.date |highlight:search.errdate |html"></div>
                     </div>
                     <div flex-container="row">
                        <div flex-item><b>referer:</b> <span ng-bind="log.referer"></span></div>
                        <div ng-bind-html="log.client |highlight:search.errclient |html"></div>
                     </div>
                  </div>
               </div>
            </li>
         </ul>
      </div>
   </lx-tab>
</lx-tabs>


<lx-dialog class="dialog dialog--xl" id="exceptionmsg" auto-close="true">
   <div class="dialog__header">
      <div class="toolbar bgc-light-blue-500 pl++">
         <span class="toolbar__label tc-white fs-title" ng-bind-html="exceptionmsg.subheader |highlight:search.exception |html"></span>
         <div class="toolbar__right">
            <button class="btn btn--l btn--white btn--icon" lx-ripple lx-dialog-close><i class="mdi mdi-close-circle-outline"></i></button>
         </div>
      </div>
   </div>

   <div class="dialog__content">
      <pre class="small" ng-bind-html="exceptionmsg.text |highlight:search.exception | html"></pre>
   </div>
   <div class="dialog__actions">
      <button clip-copy="exceptionmsg.full + '&#10; OXID [{$oView->getShopVersion()}] [{$oView->getShopFullEdition()}]'" class="btn btn--m btn--black btn--flat clipboard" lx-ripple lx-dialog-close>
         copy to clipboard
      </button>
      <button class="btn btn--m btn--black btn--flat" lx-ripple lx-dialog-close>cancel</button>
   </div>
</lx-dialog>

[{capture assign="ng"}]
   $scope.dialogs = {};
   $scope.search = [];


   [{* exception log stuff *}]
   $scope.exceptionlog = [];
   $scope.loadExceptionLog = function()
   {
   $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getExceptionLog"|replace:"&amp;":"&" }]")
   .then(function(res) {
   $scope.exceptionlog = res.data;
   LxNotificationService.success('exception log loaded');
   });
   }
   $scope.loadExceptionLog();

   $scope.exceptionmsg = [];
   $scope.exception = function(log) {
   $scope.exceptionmsg = log;
   //$scope.exceptionmsg = $scope.exceptionlog[parseInt(i)];
   LxDialogService.open('exceptionmsg');
   }

   [{* error log stuff *}]
   $scope.errorlog = [];
   $scope.loadErrorLog = function()
   {
   $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getErrorLog"|replace:"&amp;":"&" }]")
   .then(function(res) {
   $scope.errorlog = res.data;
   LxNotificationService.success('error log loaded');
   });
   }
   $scope.loadErrorLog();

   $scope.errormsg = [];
   $scope.error = function(i) {
   $scope.errormsg = $scope.errorlog[parseInt(i)];
   if (!$scope.dialogs['error']) {
   ons.createDialog('popup.error').then(function(dialog) {
   $scope.dialogs['error'] = dialog;
   $scope.dialogs['error'].show();
   });
   } else {
   $scope.dialogs['error'].show();
   }
   }

[{/capture}]


[{include file="vt_dev_footer.tpl"}]
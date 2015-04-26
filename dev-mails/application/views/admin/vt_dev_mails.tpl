[{include file="vt_dev_header.tpl"}]

<div id="devutils-mails" layout="column" layout-fill ng-controller="mailsCtrl">
   <md-toolbar>
      <div class="md-toolbar-tools" layout="row" layout-align="center center">
         <div class="container">
            <md-button ng-repeat="mail in mails" ng-click="select($index)" >{{mail.title}}</md-button>
         </div>
      </div>
   </md-toolbar>
   <md-toolbar>
         <div class="md-toolbar-tools">
            <div class="container" layout="row">

               <md-button aria-label="help" ng-click="help()">
                  <i class="fa fa-question-circle fa-lg"></i>
               </md-button>
               <md-button aria-label="reload" ng-click="preview()" id="reload">
                  <i class="fa fa-refresh fa-lg"></i>
               </md-button>

               <h4 class="left">{{current.content.Subject}}</h4>
            </div>
         </div>
      </md-toolbar>
   <md-content flex layout="row" class="container">
         <iframe flex id="html"></iframe>
         <div flex id="text" layout-padding ng-bind-html="current.content.AltBody | html"></div>
   </md-content>
</div>

<script type="text/javascript">
   [{capture assign="ctrl"}]
   var app = angular.module('devutils', ['ngMaterial'])
         .config(function($mdThemingProvider) { 
               $mdThemingProvider.theme('devutils').primaryPalette('blue').accentPalette('green').warnPalette('red'); /*.backgroundPalette('white');*/
               $mdThemingProvider.setDefaultTheme('devutils');
            })
         .filter("html", ['$sce', function ($sce) { return function(htmlCode) { return $sce.trustAsHtml(htmlCode); } }])
         .controller("mailsCtrl", function ($scope, $mdDialog, $http) {

               $scope.mails = [
                  {
                     title:  "register",
                     fnc:    "sendRegisterEmail",
                     content: []
                  },{
                     title:  "register confm",
                     fnc:    "sendRegisterConfirmEmail",
                     content: []
                  },{
                     title:  "order (user)",
                     fnc:    "sendOrderEmailToUser",
                     content: []
                  },{
                     title:  "order (owner)",
                     fnc:    "sendOrderEmailToOwner",
                     content: []
                  },{
                     title:  "order sent",
                     fnc:    "sendSendedNowMail",
                     content: []
                  },{
                     title:  "forgot pwd",
                     fnc:    "sendForgotPwdEmail",
                     content: []
                  },{
                     title:  "nl double opt-in",
                     fnc:    "sendNewsletterDbOptInMail",
                     content: []
                  }
               ];
               
               $scope.current = [];
               
               $scope.select = function (index)
               {
                  console.log(index+" selected");
                  $scope.current = $scope.mails[index];
                  console.log($scope.current.title + " active");
                  $scope.preview();
               };

               $scope.preview = function ()
               {
                  console.log("loading preview for " + $scope.current.title);
                  
                  var $button = angular.element( document.getElementById("reload") ).find('i');
                      
                  if ($scope.current.fnc)
                  {
                     $button.addClass("fa-spin");
                  
                     var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_mails&fnc=preview&mail=xxxxxx"|replace:"&amp;":"&" }]';
                     url = url.replace("xxxxxx", $scope.current.fnc);
                     
                     $http.get(url).then(function (res)
                     {
                        $scope.current.content = res.data;
                        
                        console.log("loading iframes");
                        angular.element( document.getElementById("html") ).attr('src',url+'&html=1');
                        //angular.element( document.getElementById("text") ).attr('src',url+'&text=1');
                        
                        $button.removeClass("fa-spin");
                     });
                  }
                  else { alert("function not defined!"); }
               };

               $scope.help = function ()
               {
                  var alert = $mdDialog.alert({
                    title: $scope.mails[index].helptitle,
                    ok: 'Got it!'
                 }).content($scope.mails[index].help);
                 $mdDialog.show(alert).finally(function () {
                    alert = undefined;
                 });
              };
           });
   [{/capture}]
</script>
[{oxscript add=$ctrl}]


[{include file="vt_dev_footer.tpl"}]
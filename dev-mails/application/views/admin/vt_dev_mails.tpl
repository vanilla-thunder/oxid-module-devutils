[{include file="vt_dev_header.tpl"}]

<div class="card">
   <div class="toolbar" flex-container="row">
         <button ng-repeat="mail in mails" flex-item class="btn btn--m btn--black btn--flat" lx-ripple ng-click="select( mail )">{{ mail.title }}</button>
   </div>
</div>
<div class="container">
   <div class="card">
      <hr/>
      <div class="toolbar" flex-container="row">
         <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="preview()"><i class="mdi mdi-refresh"></i> refresh</button></div>
         <div flex-item>&nbsp;&nbsp;<span class="toolbar__label fs-title">{{current.content.Subject}}</span></div>
      </div>
      <hr/>
      <div flex-container="row">
         <iframe flex-item id="html"></iframe>
         <div flex-item id="text" ng-bind-html="current.content.AltBody | html"></div>
      </div>
   </div>
</div>
   

[{capture assign="ng"}]
   $scope.mails = [
      {
         title:  "register",
         fnc:    "sendRegisterEmail",
         content: []
      },{
         title:  "register confirm",
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
      }];
               
   $scope.current = [];
               
   $scope.select = function (mail)
   {
      $scope.current = mail;
      $scope.preview();
   };

   $scope.preview = function ()
   {
      //console.log("loading preview for " + $scope.current.title);
      //var $button = angular.element( document.getElementById("reload") ).find('i');
          
      if ($scope.current.fnc)
      {
         //$button.addClass("fa-spin");
            
         var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_mails&fnc=preview&mail=xxxxxx"|replace:"&amp;":"&" }]';
         url = url.replace("xxxxxx", $scope.current.fnc);
            
         $http.get(url).then(function (res)
         {
            $scope.current.content = res.data;
            //console.log("loading iframes");
            angular.element( document.getElementById("html") ).attr('src',url+'&html=1');
            //angular.element( document.getElementById("text") ).attr('src',url+'&text=1');
            //$button.removeClass("fa-spin");
         });
      }
      else { alert("function not defined!"); }
   };
   
   // init stuff
   
   $scope.select( $scope.mails[0] );
[{/capture}]

[{include file="vt_dev_footer.tpl"}]
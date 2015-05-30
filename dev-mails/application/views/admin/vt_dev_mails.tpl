[{include file="vt_dev_header.tpl"}]

<ons-page>
   <ons-toolbar>
      <div class="center">
            <ons-toolbar-button ng-repeat="mail in mails" ng-click="select($index)">{{mail.title}}</ons-toolbar-button>
      </div>
   </ons-toolbar>
   <h4>{{current.content.Subject}}</h4>
            <ons-toolbar-button ng-click="preview()"><ons-icon icon="fa-refresh"></ons-icon></ons-toolbar-button>
   <ons-row class="container">
      <ons-col><iframe flex id="html"></iframe></ons-col>
      <ons-col><div flex id="text" layout-padding ng-bind-html="current.content.AltBody | html"></div></ons-col>
   </onx-row>
</ons-page>

<script type="text/javascript">
[{capture assign="ng"}]
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
      }];
               
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
      //console.log("loading preview for " + $scope.current.title);
      var $button = angular.element( document.getElementById("reload") ).find('i');
          
      if ($scope.current.fnc)
      {
         $button.addClass("fa-spin");
            
         var url = '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_mails&fnc=preview&mail=xxxxxx"|replace:"&amp;":"&" }]';
         url = url.replace("xxxxxx", $scope.current.fnc);
            
         $http.get(url).then(function (res)
         {
            $scope.current.content = res.data;
            //console.log("loading iframes");
            angular.element( document.getElementById("html") ).attr('src',url+'&html=1');
            //angular.element( document.getElementById("text") ).attr('src',url+'&text=1');
            $button.removeClass("fa-spin");
         });
      }
      else { alert("function not defined!"); }
   };

      /*
      $scope.help = function ()
      {
         var alert = $mdDialog.alert({
            title: $scope.mails[index].helptitle,
            ok: 'Got it!'
         }).content($scope.mails[index].help);
         $mdDialog.show(alert).finally(function () { alert = undefined; });
      };
      */
[{/capture}]
</script>


[{include file="vt_dev_footer.tpl"}]
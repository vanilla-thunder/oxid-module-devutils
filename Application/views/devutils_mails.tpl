[{include file="devutils__header.tpl"}]
<script>
    var resize = function (_el)
    {
        var iframe = document.getElementById(_el);
        var mailheight = iframe.contentWindow.document.body.scrollHeight;
        iframe.height = (mailheight + 50) + 'px';
    }
</script>

<div class="row">
    <div class="flexbox pt+">
        <a ng-repeat="mail in mails" ng-bind="mail.title" ng-click="preview( mail )" class="waves-effect waves-light btn-flat deep-orange-text"></a>
    </div>
</div>
<div class="row">
    <div class="col s12"><h4 ng-bind-html="subject|html" class="center-align"></h4></div>
</div>
<div class="row">
    <div class="col s12 l6 card">
        <iframe id="htmlframe" style="border:0;width:100%;min-height:600px;"></iframe>
    </div>
    <div class="col s12 l6 card">
        <iframe id="plainframe" style="border:0;width:100%;min-height:600px;"></iframe>
    </div>

</div>


<script>
    [{capture assign="ng"}]
    $scope.mails = [
        {
            title: "register",
            fnc: "sendRegisterEmail",
            content: []
        }, {
            title: "register confirm",
            fnc: "sendRegisterConfirmEmail",
            content: []
        }, {
            title: "order (user)",
            fnc: "sendOrderEmailToUser",
            content: []
        }, {
            title: "order (owner)",
            fnc: "sendOrderEmailToOwner",
            content: []
        }, {
            title: "order sent",
            fnc: "sendSendedNowMail",
            content: []
        }, {
            title: "forgot pwd",
            fnc: "sendForgotPwdEmail",
            content: []
        }, {
            title: "nl double opt-in",
            fnc: "sendNewsletterDbOptInMail",
            content: []
        }];

    $scope.subject = '<i class="material-icons">arrow_upward</i> click on a button to preview the email.';
    $scope.preview = function (mail)
    {
        if (mail.fnc)
        {
            var url = '[{ $oViewConf->getBaseDir()|oxaddparams:"cl=devmails&fnc=preview&mail="|replace:"&amp;":"&" }]' + mail.fnc;
            $http.get(url)
                 .then(function (res)
                 {
                     console.log("res:", res);
                     $scope.subject = res.data;
                     //console.log("loading iframes");
                     angular.element(document.getElementById("htmlframe")).attr('src', url + '&type=html');
                     angular.element(document.getElementById("plainframe")).attr('src', url + '&type=plain');
                     //angular.element( document.getElementById("text") ).attr('src',url+'&text=1');
                     //$button.removeClass("fa-spin");
                 });
        }
        else
        {
            alert("function not defined!");
        }
    };
    //setTimeout(function () { $(".tabs").tabs(); }, 300);
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]

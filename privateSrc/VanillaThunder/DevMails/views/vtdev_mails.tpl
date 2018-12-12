[{include file="_vtdev_header.tpl"}]
<script>
    var resize = function (_el) {
        var iframe = document.getElementById(_el);
        var mailheight = iframe.contentWindow.document.body.scrollHeight;
        iframe.height = (mailheight+50) + 'px';

    }
</script>

<div class="card">
    <div class="toolbar" flex-container="row">
        <button ng-repeat="mail in mails" flex-item class="btn btn--m btn--black btn--flat" lx-ripple ng-click="preview( mail )">{{ mail.title }}</button>
    </div>
</div>
<div class="container card mt" flex-item flex-container="column">
    <div flex-item><h3 class="text-center">{{subject}}</h3></div>
    <hr/>
    <div flex-item flex-container="row">
        <div flex-item><iframe width="100%" class="p+" onLoad="resize('html');" id="html"></iframe></div>
        <div flex-item><iframe width="100%" class="p+" onLoad="resize('plain');" id="plain"></iframe></div>
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

    $scope.subject = '';
    $scope.preview = function (mail) {
        //console.log("loading preview for " + mail.title);
        //var $button = angular.element( document.getElementById("reload") ).find('i');

        if (mail.fnc) {
            url = '[{ $oViewConf->getBaseDir()|oxaddparams:"cl=vtdev_mails&mail=xxxxxx"|replace:"&amp;":"&" }]'.replace("xxxxxx", mail.fnc);

            $http.get(url).then(function (res) {
                console.log("res:",res);
                $scope.subject = res.data;
                //console.log("loading iframes");
                angular.element(document.getElementById("html")).attr('src', url + '&type=html').attr('height', 'auto');
                angular.element(document.getElementById("plain")).attr('src', url + '&type=plain').attr('height', 'auto');
                //angular.element( document.getElementById("text") ).attr('src',url+'&text=1');
                //$button.removeClass("fa-spin");
            });
        }
        else {
            alert("function not defined!");
        }
    };
    [{/capture}]
</script>

[{include file="_vtdev_footer.tpl"}]

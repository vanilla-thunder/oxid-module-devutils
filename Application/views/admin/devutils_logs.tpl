[{include file="devutils__header.tpl"}]
[{if $error}]<h1>[{$error|var_dump}]</h1>[{/if}]
<div class="row pt">
    <div class="col s12">
        <ul class="tabs">
            <li class="tab col s6"><a class="active" href="#apachelog">Apache Error Log {{ '(' + apachelog.log.length + ')' }}</a></li>
            <li class="tab col s6"><a href="#oxidlog">OXID eShop Log {{ '(' + oxidlog.log.length + ')' }}</a></li>
        </ul>
    </div>
    <div id="apachelog" class="col s12">
        <div class="file-field input-fiel pt">
            <div class="waves-effect waves-light btn" ng-click="getApacheLog()">
                <i class="material-icons left">refresh</i> reload
            </div>
            <div class="file-path-wrapper">
                <input placeholder="search..." id="search_apachelog" type="text" ng-model="search.apachelog" >
            </div>
        </div>
        <table class="striped">
            <tr class="green white-text" ng-if="apachelog.log.length == 0">
                <td><i class="material-icons left">thumbs_up</i> Apache Log is empty</td>
            </tr>
            <tr class="red white-text" ng-if="(apachelog.log |filter:search.apachelog:false |limitTo:30).length == 0">
                <td><i class="material-icons left">thumbs_down</i> nothing left...</td>
            </tr>
            <tr class="my" ng-repeat="_e in apachelog.log |filter:search.apachelog:false |limitTo:30 track by $index">
                <td class="p" ng-bind-html="_e |highlight:search.apachelog |html"></td>
            </tr>
        </table>
    </div>
    <div id="oxidlog" class="col s12">
        <div class="file-field input-fiel pt">
            <div class="waves-effect waves-light btn" ng-click="getOxidLog()">
                <i class="material-icons left">refresh</i> reload
            </div>
            <div class="file-path-wrapper">
                <input placeholder="search..." id="search_oxidlog" type="text" ng-model="search.oxidlog" >
            </div>
        </div>
        <table class="striped">
            <tr class="green white-text" ng-if="oxidlog.log.length == 0">
                <td><i class="material-icons left">thumb_up</i> OXID Log is empty</td>
            </tr>
            <tr class="red white-text" ng-if="(oxidlog.log |filter:search.oxidlog:false |limitTo:30).length == 0">
                <td><i class="material-icons left">thumb_down</i> nothing left...</td>
            </tr>
            <tr class="my" ng-repeat="_e in oxidlog.log |filter:search.oxidlog:false |limitTo:30 track by $index">
                <td class="p" ng-bind-html="_e |highlight:search.oxidlog |html"></td>
            </tr>
        </table>
    </div>
</div>

<!--
<lx-tabs>

    <lx-tab lx-label="">
        <div class="container px++">
            <div class="toolbar my+" flex-container="row">
                <div flex-item="2">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="getApacheLog()"><i class="mdi mdi-refresh"></i> reload </button>
                </div>
                <div flex-item="">
                    <lx-search-filter><input type="text" ng-model="search.apachelog" placeholder="search..."></lx-search-filter>
                </div>
            </div>

            <div ng-show="apachelog.status == 'ok' && apachelog.log.length == 0" class="card m+ bgc-green-500 tc-white">
                <div class="p+">
                    <lx-icon lx-id="emoticon-cool" lx-size="xl" lx-type="flat"></lx-icon> &nbsp;&nbsp;&nbsp; <h2 style="display: inline; line-height: 2.6em; ">apache log is empty</h2>
                </div>
            </div>

            <div ng-show="apachelog.log.length > 0">
                <ul class="list logs">
                    <li class="list-row list-row--has-separator" ng-repeat="_e in apachelog.log |filter:search.apachelog:false |limitTo:30 track by $index">
                        <div class="list-row__primary">
                            <b ng-bind="$index"></b>
                        </div>
                        <div class="list-row__content">
                            <span ng-bind-html="_e |highlight:search.apachelog |html"></span>
                        </div>
                    </li>
                </ul>
            </div>
        </div>
    </lx-tab>
</lx-tabs>
-->

<lx-dialog class="dialog dialog--xl" id="exceptionmsg" auto-close="true">
    <div class="dialog__header">
        <div class="toolbar bgc-light-blue-500 pl++">
            <span class="toolbar__label tc-white fs-title" ng-bind-html="exceptionmsg.subheader |highlight:search.oxidlog |html"></span>
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
<script>
    [{capture assign="ng"}]
    $('.tabs').tabs();

    $scope.dialogs = {};
    $scope.search = {
        'oxidlog':'',
        'apachelog':''
    };


    [{* Apache error log stuff *}]
    $scope.apachelog = {'status': '', 'log': []};
    $scope.getApacheLog = function ()
    {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devlogs&fnc=getApacheLog"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status = 'ok')
                 {
                     $scope.apachelog = res.data;
                     //M.toast({html: 'Apache Log loaded'});
                 }
                 else
                 {
                     M.toast({html: 'loading Apache Log failed!'});
                 }
             });
    };
    $scope.getApacheLog();

    [{* exception log stuff *}]
    $scope.oxidlog = {'status': '', 'log': []};
    $scope.getOxidLog = function ()
    {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devlogs&fnc=getOxidLog"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status = 'ok')
                 {
                     $scope.oxidlog = res.data;
                     //LxNotificationService.success('OXID Log loaded');
                 }
                 else
                 {
                     //LxNotificationService.error('loading OXID Log failed!');
                 }
             });
    };
    $scope.getOxidLog();

    $scope.exceptionmsg = [];
    $scope.exception = function (log)
    {
        $scope.exceptionmsg = log;
        //$scope.exceptionmsg = $scope.exceptionlog[parseInt(i)];
        //LxDialogService.open('exceptionmsg');
    };


    $scope.errormsg = [];
    $scope.error = function (i)
    {
        $scope.errormsg = $scope.errorlog[parseInt(i)];
        if (!$scope.dialogs['error'])
        {
            ons.createDialog('popup.error').then(function (dialog)
            {
                $scope.dialogs['error'] = dialog;
                $scope.dialogs['error'].show();
            });
        }
        else
        {
            $scope.dialogs['error'].show();
        }
    };
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
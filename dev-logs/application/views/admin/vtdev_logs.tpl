[{include file="_vtdev_header.tpl"}]

[{if $error}]<h1>[{$error|var_dump}]</h1>[{/if}]

<lx-tabs>
    <lx-tab lx-label="shop exceptions {{ '(' + exceptions.log.length + ')' }}">
        <div class="card">
            <div class="container toolbar" flex-container="row">
                <div flex-item="1">
                    <button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="loadExceptionLog()"><i class="mdi mdi-refresh"></i> refresh</button>
                </div>
                <div flex-item="4">
                    <lx-search-filter><input type="text" ng-model="search.exception" placeholder="search..."></lx-search-filter>
                </div>
            </div>
        </div>

        <div class="card mt++" ng-class="{'bgc-green-500 tc-white':exceptions.log.length == 0}">

            <div ng-show="exceptions.log.length == 0" class="container ">
                <div class="p+">
                    <lx-icon lx-id="emoticon-cool" lx-size="xl" lx-type="flat"></lx-icon> &nbsp;&nbsp;&nbsp; <h2 style="display: inline; line-height: 2.6em; ">exception log is empty</h2>
                </div>
            </div>

            <ul class="list logs">
                <li class="list-row list-row--has-separator" ng-repeat="log in exceptions.log |filter:{full:search.exception}:false |limitTo:20" ng-click="exception( log )">
                    <div class="list-row__content">
                        <div class="h3">{{ $index+1 }} # <span ng-bind-html="log.header |highlight:search.exception |html"></span></div>
                        <span ng-bind-html="log.subheader |highlight:search.exception |html"></span>
                    </div>
                </li>
            </ul>
        </div>
    </lx-tab>

    <lx-tab lx-label="php errors {{ '(' + errors.log.length + ')' }}">
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
        </div>

        <div class="card mt++" ng-class="{'bgc-green-500 tc-white':errors.log.length == 0}">

            <div ng-show="errors.log.length == 0" class="container ">
                <div class="p+">
                    <lx-icon lx-id="emoticon-cool" lx-size="xl" lx-type="flat"></lx-icon> &nbsp;&nbsp;&nbsp; <h2 style="display: inline; line-height: 2.6em; ">error log is empty</h2>
                </div>
            </div>

            <ul class="list mt++ logs" ng-show="errors.log.length > 0">
                <li class="list-row list-row--has-separator" ng-repeat="log in errors.log |filter:{full:search.error}:false |filter:{in:search.errin}:false |filter:{client:search.errclient}:false |filter:{date:search.errdate} |limitTo:30">
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
<script>
    [{capture assign="ng"}]
    $scope.dialogs = {};
    $scope.search = [];


    [{* exception log stuff *}]
    $scope.exceptions = {'status': '', 'log': []};
    $scope.loadExceptionLog = function () {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getExceptionLog"|replace:"&amp;":"&" }]")
                .then(function (res) {
                    if(res.data.status = 'ok') {
                        $scope.exceptions = res.data;
                        LxNotificationService.success('exception log');
                    } else {
                        LxNotificationService.error('loading exceptions failed!');
                    }
                });
    };
    $scope.loadExceptionLog();

    $scope.exceptionmsg = [];
    $scope.exception = function (log) {
        $scope.exceptionmsg = log;
        //$scope.exceptionmsg = $scope.exceptionlog[parseInt(i)];
        LxDialogService.open('exceptionmsg');
    };

    [{* error log stuff *}]
    $scope.errors = {'status': '', 'log': []};
    $scope.loadErrorLog = function () {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getErrorLog"|replace:"&amp;":"&" }]")
                .then(function (res) {
                    if(res.data.status = 'ok') {
                        $scope.errors = res.data;
                        LxNotificationService.success('error log');
                    } else {
                        LxNotificationService.error('loading error log failed!');
                    }
                });
    };
    $scope.loadErrorLog();

    $scope.errormsg = [];
    $scope.error = function (i) {
        $scope.errormsg = $scope.errorlog[parseInt(i)];
        if (!$scope.dialogs['error']) {
            ons.createDialog('popup.error').then(function (dialog) {
                $scope.dialogs['error'] = dialog;
                $scope.dialogs['error'].show();
            });
        } else {
            $scope.dialogs['error'].show();
        }
    };
    [{/capture}]
</script>

[{include file="_vtdev_footer.tpl"}]
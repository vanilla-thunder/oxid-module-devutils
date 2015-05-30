[{include file="vt_dev_header.tpl"}]

[{if $error}]
    <h1>[{$error|var_dump}]</h1>
[{/if}]
<div class="container">
<lx-tabs>
    <lx-tab heading="shop exceptions">
        <div class="card">
            <div class="toolbar" flex-container="row">
                <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="loadExceptionLog()"><i class="mdi mdi-refresh"></i> refresh</button></div>
                <div flex-item="4"><lx-search-filter model="search.exception" filter-width="100%" placeholder="search..."></lx-search-filter></div>
            </div>
        
            <hr/>
            
            <ul class="list mt++ logs">
            <li class="list-row list-row--has-separator" ng-repeat="log in exceptionlog |filter:{full:search.exception}:false |limitTo:15" ng-click="exception( log )">
                <div class="list-row__content">
                    <div class="h3">{{ $index+1 }} # <span ng-bind-html="log.header |highlight:search.exception |html"></span></div>
                    <span ng-bind-html="log.subheader |highlight:search.exception |html"></span>
                </div>
            </li>
            </ul>
        </div>
    </lx-tab>

    <lx-tab heading="webserver errors">
        <div class="card">
            <div class="toolbar" flex-container="row">
                <div><button class="btn btn--l btn--white btn--raised" lx-ripple ng-click="loadErrorLog()"><i class="mdi mdi-refresh"></i> refresh</button></div>
                <div flex-item><lx-search-filter model="search.error" filter-width="100%" placeholder="search..."></lx-search-filter></div>
                <div flex-item><lx-search-filter model="search.errin" filter-width="100%" placeholder="in..."></lx-search-filter></div>
                <div flex-item><lx-text-field label="search for client ip"><input type="text" ng-model="search.errip" placeholder="[{$ip}]"></lx-text-field></div>
            </div>
        
            <hr/>
        
            <ul class="list mt++ logs">
                <li class="list-row list-row--has-separator" ng-repeat="log in errorlog |filter:{header:search}:false |filter:{in:searchin} |filter:{client:searchclient} |filter:{date:searchdate} | limitTo:20">
                    <div class="list-row__primary">
                        <i ng-show="log.type=='error'" class="icon icon--s icon--grey icon--flat mdi mdi-send"></i>
                        <i ng-show="log.type=='warning'" class="icon icon--s icon--grey icon--flat mdi mdi-send"></i>
                    </div>

                    <div class="list-row__content">
                        <div class="h4">{{ $index+1 }} # <span ng-bind-html="log.header |highlight:search.error |html"></span></div>
                        
                        <span ng-bind-html="log.subheader |highlight:search |html"></span>
                        
                        <div class="fs-body-1 tc-black-2" flex-container="row">
                            <div flex-item ng-bind="log.date"></div>
                            <div flex-item><b>in:</b> <span ng-bind-html="log.in |highlight:searchin |html"></span></div>
                            <div flex-item ng-bind-html="log.client |highlight:searchclient |html"></div>
                        </div>
                        <div class="fs-body-1 tc-black-2"><b>referer:</b> <span ng-bind="log.referer"></span></div>
                    </div>
                </li>
            </ul>
        </div>
    </lx-tab>
</lx-tabs>
</div>

<lx-dialog class="dialog dialog--xl" id="exceptionmsg" auto-close="true" >
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
        <button class="btn btn--m btn--black btn--flat" lx-ripple>copy to clipboard</button>
        <button class="btn btn--m btn--black btn--flat" lx-ripple lx-dialog-close>cancel</button>
    </div>
</lx-dialog>


[{*


<ons-template id="popup.error">
    <ons-dialog var="dialog" cancelable>
        <ons-toolbar inline><div class="center" ng-bind="errormsg"></div></ons-toolbar>
        <ons-button modifier="large" ng-click="dialog.hide()">close</ons-button>
    </ons-dialog>
</ons-template>
*}]

[{capture assign="ng"}]
    $scope.dialogs = {};

    [{* exception log stuff *}]
    $scope.exceptionlog = [];
    $scope.loadExceptionLog = function()
    {
        //console.log("loading exception log");
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getExceptionLog"|replace:"&amp;":"&" }]")
            .then(function(res) { $scope.exceptionlog = res.data; LxNotificationService.success('exception log loaded'); });
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
        //console.log("loading error log");
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_logs&fnc=getErrorLog"|replace:"&amp;":"&" }]")
            .then(function(res) { $scope.errorlog = res.data; LxNotificationService.success('error log loaded'); });
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
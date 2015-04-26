[{include file="vt_dev_header.tpl"}]

[{oxscript include=$oViewConf->getModuleUrl("_dev-core","src/ace-builds/src-min-noconflict/ace.js")}]
[{oxscript include=$oViewConf->getModuleUrl("_dev-core","src/angular-ui-ace/ui-ace.min.js")}]

<div class="container" id="devutils-console" layout="column" ng-controller="consoleCtrl">
    <div>
        <div id="editor" ui-ace="{theme:'github',mode:'php',onLoad: aceLoaded,}"></div>
    </div>
    <div>
        <md-button class="md-raised md-warn" ng-click="eval();">run code</md-button>
    </div>
    <div>
        <div id="output" ng-bind-html="output | html"></div>
    </div>
</div>
<script>
    [{capture assign="ngCtrl"}]

    var app = angular.module('devutils', ['ngMaterial', 'ui.ace']);
    app.filter("html", ['$sce', function($sce) { return function(htmlCode){ return $sce.trustAsHtml(htmlCode); } }]);
    app.controller("consoleCtrl", ['$scope', '$http', function ($scope, $http) {

        $scope.ace;
        $scope.output;

        $scope.aceLoaded = function (_editor) {
            $scope.ace = _editor.getSession();
        };

        $scope.eval = function () {
            var source = $scope.ace.getValue();

            $http({
                method: 'POST',
                url: '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_console&fnc=run"|replace:"&amp;":"&" }]',
                data: {code: source},  // pass in data as strings
                headers: {'Content-Type': 'application/json'}  // set the headers so angular passing info as form data (not request payload)
            }).
                    success(function (data, status, headers, config) {
                        $scope.output = data.output;
                        if (data.error) {
                            alert(data.error);
                        }
                    }).
                    error(function (data, status, headers, config) {
                        $scope.output = status+' : '+data.error;
                    });
        };
    }]);

    [{/capture}]
</script>
[{oxscript add=$ngCtrl}]

[{*

        <div id="codeinput" >[{$codeinput|default:""}]</div>
        

    <div class="row">
        <div class="small-12 medium-6 columns">
            <form name="vtdu_console" id="console" class="form-horizontal" action="[{ $oViewConf->getSelfLink() }]" method="post">
                <input type="hidden" name="cl" value="[{$oView->getClassName()}]"/>
                <input type="hidden" name="fnc" value="doTest"/>
                <input type="hidden" name="codeinput" value="" id="target"/>
            </form>
            <button type="submit" class="button expand" onclick="Javascript:eval();">EVALUATE</button>
        </div>
        <div class="small-12 medium-6 columns text-center">
            <strong style="line-height: 20px; color: red"><br/>all the php code will be evaluated!<br/>bad code may brake your shop or server!</strong>
        </div>
    </div>

        [{if $codeerror}]
            <pre>[{$codeerror|var_dump}]</pre>
        [{else}]
            <textarea class="form-control" style="min-height: [{if $codeoutput}]3[{else}]2[{/if}]00px;">[{$codeoutput|default:""}]</textarea>
        [{/if}]


*}]

[{include file="vt_dev_footer.tpl"}]
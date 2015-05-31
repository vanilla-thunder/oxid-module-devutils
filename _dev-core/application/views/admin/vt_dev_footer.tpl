<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/jquery/dist/jquery.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/velocity/velocity.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/moment/min/moment-with-locales.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/angular/angular.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/lumx/dist/lumx.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/zeroclipboard/dist/ZeroClipboard.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/ng-clip/dest/ng-clip.min.js")}]"></script>

[{ oxscript }]

<script>
    var app = angular.module('devApp', [ [{$smarty.capture.appdep}] ] )
        .filter("html", ['$sce', function ($sce) { return function(htmlCode) { return $sce.trustAsHtml(htmlCode); } }])
        .filter("highlight", function () {
            return function($value, $param) {
                return $param ? $value.replace( new RegExp($param, "ig"), function swag(x){ return '<b class="hl">'+x+'</b>';}) : $value;
                //return $param ? $value.split($param).join('<b class="hl">'+$param+'</b>') : $value;
            } 
        })
        .controller('devCtrl', function($scope, $http, LxDialogService, LxNotificationService, LxProgressService) {
            [{$ng}]
        });    
</script>


</body>
</html>
[{if $b2t != false}]
<div id="backtotop">
   <button class="btn btn--xl btn--blue btn--fab" lx-ripple ng-click="scrolltotop()"><i class="mdi mdi-chevron-double-up"></i></button>
</div>
[{/if}]
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/jquery/dist/jquery.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/velocity/velocity.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/moment/min/moment-with-locales.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/angular/angular.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/lumx/dist/lumx.min.js")}]"></script>

<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/zeroclipboard/dist/ZeroClipboard.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/ng-clip/dest/ng-clip.min.js")}]"></script>

<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/masonry/dist/masonry.pkgd.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/imagesloaded/imagesloaded.pkgd.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("_dev-core","src/angular-masonry-directive/src/angular-masonry-directive.js")}]"></script>


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

            $scope.scrolltotop = function() { $("body").animate({scrollTop: 0}, "slow"); };
        });
</script>


</body>
</html>
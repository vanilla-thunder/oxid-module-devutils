[{if $b2t != false}]
    <div id="backtotop">
        <button class="btn btn--xl btn--blue btn--fab" lx-ripple ng-click="scrolltotop()"><i class="mdi mdi-chevron-double-up"></i></button>
    </div>
[{/if}]
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/jquery/dist/jquery.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/velocity/velocity.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/moment/min/moment-with-locales.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/angular/angular.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/lumx/dist/lumx.min.js")}]"></script>

<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/zeroclipboard/dist/ZeroClipboard.min.js")}]"></script>
<script type="text/javascript" src="[{$oViewConf->getModuleUrl("dev-core","out/libs/ng-clip/dest/ng-clip.min.js")}]"></script>

[{ oxscript }]

<script>
var app = angular.module('devApp', [ 'lumx','ngClipboard'[{$smarty.capture.appdep}] ])
        .filter("html", ['$sce', function ($sce) {
            return function (htmlCode) {
                return $sce.trustAsHtml(htmlCode);
            }
        }])
        .filter("highlight", function () {
            return function ($value, $param) {
                return $param ? $value.replace(new RegExp($param, "ig"), function swag(x) {
                    return '<b class="hl">' + x + '</b>';
                }) : $value;
                //return $param ? $value.split($param).join('<b class="hl">'+$param+'</b>') : $value;
            }
        })
        .config(['ngClipProvider', function (ngClipProvider) {
            ngClipProvider.setPath('[{$oViewConf->getModuleUrl("dev-core","out/libs/zeroclipboard/dist/ZeroClipboard.swf")}]');
        }])
        .controller('devCtrl', function ($scope, $http, LxDialogService, LxNotificationService) {
            [{$ng}]

            $scope.scrolltotop = function () {
                $("body").animate({scrollTop: 0}, "slow");
            };
        });
</script>

</body>
</html>
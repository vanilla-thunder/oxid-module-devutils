</div>
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.min.js")}]
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/angular.min.js")}]
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/ZeroClipboard.min.js")}]
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/ng-clip.min.js")}]
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/ng-sortable.min.js")}]
[{oxscript include=$oViewConf->getModuleUrl("vt-devutils","out/js/materialize.min.js")}]
[{ oxscript }]

<script>
    M.AutoInit();
    var app = angular.module('devApp', ['ngClipboard','as.sortable'[{$smarty.capture.appdep}] ]);
    app.filter("html", ['$sce', function ($sce)
    {
        return function (htmlCode)
        {
            return $sce.trustAsHtml(htmlCode);
        }
    }])
        .directive('copyToClipboard', function () {
            return {
                restrict: 'A',
                link: function (scope, elem, attrs) {
                    elem.click(function () {
                        if (attrs.copyToClipboard) {
                            var $temp_input = $("<input>");
                            $("body").append($temp_input);
                            $temp_input.val(attrs.copyToClipboard).select();
                            document.execCommand("copy");
                            $temp_input.remove();
                        }
                    });
                }
            };
        })
       .filter("highlight", function ()
       {
           return function ($value, $param)
           {
               //console.log($param);
               //console.log($value);
               return $param && $value ? $value.replace(new RegExp($param, "ig"), function swag(x)
               {
                   return '<b class="red-text">' + x + '</b>';
               }) : $value;
               //return $param ? $value.split($param).join('<b class="hl">'+$param+'</b>') : $value;
           }
       })
       .config(['ngClipProvider', function (ngClipProvider)
       {
           ngClipProvider.setPath('[{$oViewConf->getModuleUrl("vt-devutils","out/ZeroClipboard.swf")}]');
       }])
       .controller('devCtrl', function ($scope, $http, $timeout)
       {
           $scope.Object = Object;

           [{$ng}]

       });
</script>

</body>
</html>
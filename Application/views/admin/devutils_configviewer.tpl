[{include file="devutils__header.tpl"}]

<div class="row pt" ng-if="Object.keys(summary).length > 0">
    <div class="col s12">
        <ul class="tabs">
            <li class="tab col" ng-repeat="(_mod, _configs) in summary track by $index"><a ng-href="#oxconfig{{$index}}" ng-bind="_mod"></a></li>
        </ul>
    </div>
    <div ng-repeat="(_mod, _configs) in summary track by $index" id="oxconfig{{$index}}" class="col s12">
        <table class="striped">
            <tr></tr>
            <tr>
                <th align="left"><input type="text" ng-model="search.OXVARNAME" placeholder="Name"></th>
                <th align="left"><input type="text" ng-model="search.OXVARTYPE" placeholder="Type"></th>
                <th align="left"><input type="text" ng-model="search.SIZE" placeholder="Size >="></th>
                <th align="left"><input type="text" ng-model="search.OXTIMESTAMP" placeholder="Timestamp"></th>
            </tr>
            <tr ng-repeat="_conf in _configs |filter:{OXVARNAME:search.OXVARNAME}:false |filter:{OXVARTYPE:search.OXVARTYPE}:typeFilter |filter:{SIZE:search.SIZE}:sizeFilter |filter:{OXTIMESTAMP:search.OXTIMESTAMP}:false "
                ng-click="getConfigValue(_conf.OXVARNAME,_conf.OXMODULE)">
                <td ng-bind-html="_conf.OXVARNAME |highlight:search.OXVARNAME |html"
                    class="waves-effect waves-light" style="display: block;">
                    <i class="material-icons left">search</i>
                </td>
                <td ng-bind-html="_conf.OXVARTYPE |highlight:search.OXVARTYPE |html"></td>
                <td ng-bind="_conf.SIZE + 'b'"></td>
                <td ng-bind-html="_conf.OXTIMESTAMP |highlight:search.OXTIMESTAMP |html"></td>
            </tr>
        </table>
    </div>
</div>

<!-- Modal Structure -->
<div id="configmodal" class="modal">
    <div class="modal-content">
        <h4 ng-bind="oxvar.name"></h4>
        <pre class="m0" ng-bind="oxvar.value|json"></pre>
    </div>
</div>

<script>
    [{capture assign="ng"}]
    $('#configmodal').modal();

    $scope.search = {};
    $scope.summary = {};
    $scope.getConfigSummary = function ()
    {
        $http.get('[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devconfigviewer&fnc=getConfigSummary"|replace:"&amp;":"&" }]')
             .then(function (res)
             {
                 if (res.data.status = 'ok')
                 {
                     $scope.summary = res.data.summary;
                     setTimeout(function () { $(".tabs").tabs(); }, 300);
                 }
                 else
                 {
                     //LxNotificationService.error('could not load config summary! Please check error logs.');
                 }
             });
    };
    $scope.getConfigSummary();

    $scope.oxvar = {
        'name':'',
        'value' : {}
    };
    $scope.getConfigValue = function (oxvarname,oxmodule)
    {
        $http.get('[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devconfigviewer&fnc=getConfigValue"|replace:"&amp;":"&" }]&oxvarname=' + oxvarname + '&oxmodule=' + oxmodule || "")
             .then(function (res)
             {
                 console.log(res);
                 if (res.data.status = 'ok')
                 {
                     $scope.oxvar.name = oxvarname;
                     $scope.oxvar.value = res.data.value;
                     $('#configmodal').modal("open");
                 }
                 else
                 {
                     //LxNotificationService.error('could not load config summary! Please check error logs.');
                 }
             });
    };

    $scope.typeFilter = function (actual, expect)
    {
        if (!expect) return true;
        else return actual.indexOf(expect) === 0;
    };
    $scope.sizeFilter = function (actual, expect)
    {
        if (!expect) return true;
        else return parseInt(actual) >= parseInt(expect);
    };
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
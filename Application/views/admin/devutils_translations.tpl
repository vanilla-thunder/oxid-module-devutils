[{include file="devutils__header.tpl"}]
[{if $error}]<h1>[{$error|var_dump}]</h1>[{/if}]
<div class="row">
    <table class="striped">
        <colgroup>
            <col width="30"/>
            <col width="35%"/>
            <col width="*"/>
            <col width="30%"/>
        </colgroup>
        <thead>
        <tr>
            <td ng-bind="(translations |filter:{key:search.key}:false |filter:{value:search.value}:false).length"></td>
            <td><input type="text" ng-model="search.key" placeholder="Key"></td>
            <td style="color: #cfcfcf; font-size: 120%;">&nbsp;&nbsp;&nbsp;Dateien</td>
            <td><input type="text" ng-model="search.value" placeholder="finale Übersetzung"></td>
        </tr>
        </thead>
        <tbody>
            <tr ng-repeat="t in translations |filter:{key:search.key}:false |filter:{value:search.value}:false |limitTo:50">

                <td ng-bind="$index+1+':'"></td>
                <td ng-bind-html="t.key|highlight:search.key |html"></td>
                <td>
                    <ol>
                        <li ng-repeat="(file,value) in allTranslations[t.key]">
                            <em>{{ file }}</em><br/>
                            <span ng-if="Object.keys(allTranslations[t.key]).length > 1">"{{value}}"</span>
                        </li>
                    </ol>
                </td>
                <td ng-bind-html="t.value|highlight:search.value |html"></td>
            </tr>
        </tbody>
    </table>
</div>
<script>
    [{capture assign="ng"}]
    $('.tabs').tabs();

    $scope.search = { key:'', files:'', value:'' };

    $scope.translations = [];
    $scope.getTranslations = function ()
    {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=getTranslations"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status = 'ok')
                 {
                     console.log(res);
                     $scope.translations = res.data;
                     //M.toast({html: 'Apache Log loaded'});
                 }
                 else
                 {
                     M.toast({html: 'loading Apache Log failed!'});
                 }
             });
    };
    $scope.getTranslations();

    $scope.allTranslations = {};
    $scope.getAllTranslations = function ()
    {
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=getAllTranslations"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status = 'ok')
                 {
                     console.log(res);
                     $scope.allTranslations = res.data;
                     //M.toast({html: 'Apache Log loaded'});
                 }
                 else
                 {
                     M.toast({html: 'loading translations failed!'});
                 }
             });
    }
    $scope.getAllTranslations();
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
[{include file="devutils__header.tpl"}]
<div class="progress" ng-show="loading > 0"><div class="indeterminate"></div></div>

[{if $error}]<h1>[{$error|var_dump}]</h1>[{/if}]

<div class="row">
    <div class="card p+ mt+ red white-text" ng-if="response" ng-bind="response"></div>
    <table class="striped">
        <colgroup>
            <col width="30"/>
            <col width="35%"/>
            <col width="*"/>
            <col width="30%"/>
            <col width="50"/>
        </colgroup>
        <thead>
        <tr>
            <td ng-bind="(translations |filter:{key:search.key}:false |filter:{value:search.value}:false).length"></td>
            <td><input type="text" ng-model="search.key" placeholder="Key"></td>
            <td style="color: #cfcfcf; font-size: 120%;">&nbsp;&nbsp;&nbsp;Dateien</td>
            <td colspan="2"><input type="text" ng-model="search.value" placeholder="finale Übersetzung"></td>
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
                        <a class="btn-flat btn-small" title="löschen"
                           ng-if="file.indexOf('cust_lang.php') > 1" ng-click="deleteCustomTranslation(file,t)">
                            <i class="material-icons">delete</i>
                        </a>
                    </li>
                </ol>
            </td>
            <td ng-bind-html="t.value|highlight:search.value |html" style="padding-left: 15px"></td>
            <td align="right">
                <a class="btn-floating btn-small grey darken-1" title="bearbeiten" ng-click="editTranslation(t)">
                    <i class="material-icons">edit</i>
                </a>
            </td>
        </tr>
        </tbody>
    </table>

    <div id="editmodal" class="modal">
        <div class="modal-content">
            <h4>Übersetzung bearbeiten</h4>
            <label for="key">Key</label>
            <div class="input-field">
                <input id="key" type="text" ng-model="edit.key">
            </div>

            <label for="translation">Übersetzung</label>
            <div class="input-field">
                <textarea id="translation" class="materialize-textarea" ng-model="edit.value"></textarea>
            </div>
        </div>
        <div class="modal-footer">
            <a href="#" class="waves-effect waves-green btn-flat" ng-click="saveCustomTranslation()">Speichern</a>
        </div>
    </div>
</div>
<script>
    [{capture assign="ng"}]
    $scope.loading = 0;
    $scope.response = "";

    $scope.search = {key: '', files: '', value: ''};

    $scope.translations = [];
    $scope.getTranslations = function ()
    {
        $scope.loading++;
        $scope.response = "";
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=getTranslations"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status === 'ok') $scope.translations = res.data;
                 else if (res.data.status === 'error') $scope.response = res.data.msg;
                 else $scope.response = "Übersetzungen konnten nicht geladen werden, bitte prüfe deine Fehler Logs."
                 $scope.loading--;
             });
    };
    $scope.getTranslations();

    $scope.allTranslations = {};
    $scope.getAllTranslations = function ()
    {
        $scope.loading++;
        $scope.response = "";
        $http.get("[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=getAllTranslations"|replace:"&amp;":"&" }]")
             .then(function (res)
             {
                 if (res.data.status === 'ok') $scope.allTranslations = res.data;
                 else if (res.data.status === 'error') $scope.response = res.data.msg;
                 else $scope.response = "Übersetzungen konnten nicht geladen werden, bitte prüfe deine Fehler Logs."
                 $scope.loading--;
             });
    }
    $scope.getAllTranslations();

    $scope.edit = {};
    $scope.editTranslation = function (translation)
    {
        $scope.edit = translation;
        $('#editmodal').modal('open');
    };
    $scope.saveCustomTranslation = function ()
    {
        $scope.loading++;
        $scope.response = "";
        $http.post(
            "[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=saveCustomTranslation"|replace:"&amp;":"&" }]",
            $scope.edit
        ).then(function (res)
        {
            console.log(res);
            if (res.data.status === 'ok')
            {
                M.toast({html: 'Übersetzung geändert.\nErneuere den Cache...'});
                $timeout(function ()
                {
                    $scope.getTranslations();
                    $scope.getAllTranslations();
                    $scope.loading--;
                }, 3000);
                $('#editmodal').modal('close');
            }
            else if (res.data.status === 'error')
            {
                $scope.response = res.data.msg;
                $('#editmodal').modal('close');
                $scope.loading--;
            }
            else
            {
                console.log(res);
                $scope.response = 'Ein Fegler ist aufgetreten, bitte prüfe deine Logs';
                $('#editmodal').modal('close');
                $scope.loading--;
            }
        });
    };
    $scope.deleteCustomTranslation = function (file, translation)
    {
        $scope.loading++;
        $scope.response = "";
        $http.post(
            "[{ $oViewConf->getSelfLink()|oxaddparams:"cl=devtranslations&fnc=deleteCustomTranslation"|replace:"&amp;":"&" }]",
            {'file': file, 'translation': translation}
        ).then(function (res)
        {
            console.log(res);
            if (res.data.status === 'ok')
            {
                M.toast({html: 'Übersetzung gelöscht.\nErneuere den Cache...'});
                $timeout(function ()
                {
                    $scope.getTranslations();
                    $scope.getAllTranslations();
                    $scope.loading--;
                }, 3000);
            }
            else if (res.data.status === 'error')
            {
                $scope.response = res.data.msg;
                $scope.loading--;
            }
            else
            {
                $scope.response = 'Ein Fegler ist aufgetreten, bitte prüfe deine Logs';
                console.log(res);
                $scope.loading--;
            }
        });
    };
    $('.modal').modal();
    [{/capture}]
</script>

[{include file="devutils__footer.tpl"}]
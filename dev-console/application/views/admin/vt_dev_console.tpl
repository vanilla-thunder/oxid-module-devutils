[{include file="vt_dev_header.tpl"}]

[{oxscript include=$oViewConf->getModuleUrl("dev-console","out/libs/ace-builds/src-min-noconflict/ace.js")}]
[{oxscript include=$oViewConf->getModuleUrl("dev-console","out/libs/angular-ui-ace/ui-ace.min.js")}]

<div class="container">
   <div class="card" flex-container="column">
      <div id="editor" ui-ace="{theme:'github', mode: {path:'ace/mode/php',inline:true}, onLoad: aceLoaded,blockScrolling: 'Infinity'}"></div>
      <div flex-container="row">
         <button flex-item button class="btn btn--m btn--red btn--raised" lx-ripple ng-click="eval();">run code</button>
      </div>
      <div id="output" ng-bind-html="output | html"></div>
   </div>
</div>

[{capture name=appdep}][{$smarty.capture.appdep}],'ui.ace'[{/capture}]
<script>
   [{capture assign="ng"}]
   $scope.ace;
   $scope.output;

   $scope.aceLoaded = function (_editor) {
      _editor.$blockScrolling = 'Infinity';
      //session.setMode({path: 'ace/mode/php', inline: true});
      $scope.ace = _editor.getSession();
   };

   $scope.eval = function () {
      var source = $scope.ace.getValue();

      $http({
         method: 'POST',
         url: '[{ $oViewConf->getSelfLink()|oxaddparams:"cl=vtdev_console&fnc=run"|replace:"&amp;":"&" }]',
         data: {code: source},  // pass in data as strings
         headers: {'Content-Type': 'application/json'}  // set the headers so angular passing info as form data (not request payload)
      })
              .success(function (data, status, headers, config) {
                 $scope.output = data.output;
                 if (data.error) {
                    alert(data.error);
                 }
              })
              .error(function (data, status, headers, config) {
                 $scope.output = status + ' : ' + data.error;
              });
   };
   [{/capture}]
</script>

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
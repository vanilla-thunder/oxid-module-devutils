<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
    <head>
        <title>Category Banner</title>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta http-equiv="X-UA-Compatible" value="IE=edge" />
        [{if isset($meta_refresh_sec,$meta_refresh_url) }]
         <meta http-equiv=Refresh content="[{$meta_refresh_sec}];URL=[{$meta_refresh_url|replace:"&amp;":"&"}]" />
      [{/if}]

      <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]main.css" />
      <link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]colors.css" />
      <link rel="stylesheet" type="text/css" href="[{$oViewConf->getResourceUrl()}]yui/build/assets/skins/sam/container.css" />
		<script type="text/javascript">
			function checkForm() {
				//if (confirm("wirklich löschen?")) {
				document.forms.scratchpad.submit();
				//} else {
        //	return false;
        //}
        }
        </script>
    </head>
    <body>
        <div class="[{$box|default:'box'}]" style="[{if !$box && !$bottom_buttons}]height: 98%;[{/if}]">

            <fieldset>
                <legend><strong style="font-size: 20px;">input</strong></legend>
                <form name="scratchpad" id="scratchpad" action="[{ $oViewConf->getSelfLink() }]" method="post">
                    <input type="hidden" name="cl" value="vtdu_scratchpad" />
                    <input type="hidden" name="fnc" value="doTest" />
                    <textarea name="codeinput" style="width:100%; height: 250px; border: 0; font-size:16px;">[{$codeinput|default:""}]</textarea>
                </form>
            </fieldset>
            <button onclick="Javascript:return checkForm();" style="padding: 5px 35px; margin: 10px; color:white; background: #ff3600;float:right;">go</button>
            <strong style="line-height: 24px; float:right;text-align: center;">
                <span style="font-size: 14px;color: #ff3600">all the php code will be evaluated! bad code may broke your shop or server!</span><br/>
                use it only if you know what you do and you better backup!</strong>
            <div style="clear: both;"></div>
            <fieldset>
                <legend><strong style="font-size: 20px;">output</strong></legend>
                <textarea style="margin: 0;width:100%; min-height: 200px; border: 0; font-size:16px;">[{$codeoutput|default:""}]</textarea>
                [{if $codeerror !== NULL}]<hr/>[{$codeerror|var_dump}][{/if}]
            </fieldset>


            [{include file="bottomnaviitem.tpl"}]
            [{include file="bottomitem.tpl"}]

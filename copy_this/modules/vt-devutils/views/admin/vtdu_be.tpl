<!DOCTYPE html>
<html lang="en">
<head>
	<title>vt DevUtils 2</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<link rel="stylesheet" media="screen" href="[{$oViewConf->getModuleUrl('vt-devutils','out/css/bootstrap.min.css') }]">
	<link rel="stylesheet" media="screen" href="[{$oViewConf->getModuleUrl('vt-devutils','out/css/vt-devutils.css') }]">
</head>
<body>
<div class="accordion" id="accordion">

	<div class="accordion-group">
		<div id="collapseThree" class="accordion-body collapse">
			<div class="accordion-inner">
				<div class="row-fluid">
				</div>
			</div>
		</div>
		<div class="accordion-heading"><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseThree">Second one</a></div>
	</div>

	<div class="accordion-group">
		<div id="collapseTwo" class="accordion-body collapse">
			<div class="accordion-inner">
				<div id="debugsettings" class="row-fluid">
					[{foreach from=$oView->getDebugSettings() key="key" item="val"}]
						<div class="span4">
						<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu_be&fnc=toggledebugsetting&setting=[{$key}]&ajax=1" class="ajax [{if $val}]on[{/if}]" title="[{oxmultilang ident='SHOP_MODULE_'|cat:$key}]">
							<img id="[{$key}]" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/")}]debugsetting_[{$key}][{if $val}]_on[{/if}].png"/>
						</a></div>
					[{/foreach}]
				</div>
			</div>
		</div>
		<div class="accordion-heading"><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo">Debug Settings</a></div>
	</div>


	<div class="accordion-group">
		<div id="collapseOne" class="accordion-body collapse in">
			<div class="accordion-inner">
				<div class="row-fluid">
					<div class="span6">
						<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu_be&fnc=clearLang&ajax=1" class="ajax btn btn-block" title="[{oxmultilang ident='vtdu_clearlang'}]" data-toggle="tooltip" data-placement="bottom">
							<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearlang.png")}]"/> lang
						</a>
					</div>
					<div class="span6">
						<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu_be&fnc=clearPhp&ajax=1" class="ajax btn btn-block" title="[{oxmultilang ident='vtdu_clearphp'}]" data-toggle="tooltip" data-placement="bottom">
							<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearphp.png")}]"/> php
						</a>
					</div>
				</div>
				<div class="row-fluid">
					<div class="span6">
						<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu_be&fnc=clearTmp&ajax=1" class="ajax btn btn-block" title="[{oxmultilang ident='vtdu_cleartmp'}]" data-toggle="tooltip">
							<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/cleartmp.png")}]"/> all
						</a>
					</div>
					<div class="span6">
						<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu_be&fnc=clearTpl&ajax=1" class="ajax btn btn-block" title="[{oxmultilang ident='vtdu_clearsmarty'}]" data-toggle="tooltip">
							<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearsmarty.png")}]"/> tpl
						</a>
					</div>
				</div>
			</div>
		</div>
		<div class="accordion-heading"><a class="accordion-toggle" data-toggle="collapse" data-parent="#accordion" href="#collapseOne">clear cache</a></div>
	</div>

</div>

<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery-1.9.1.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/bootstrap.min.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.center.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.default.js")}]"></script>
<script type="text/javascript">
	function generatenoty(type, text)
	{
  		var n = noty({
  			type: type,
  			text: text,
    		dismissQueue: true,
    		timeout: 1500,
    		modal: false,
  			layout: 'center',
  			theme: 'defaultTheme'
  		});
  	}

	$(function ()
	{
		//$("#accordion").accordion({ heightStyle: "fill" });
		//$('#collapseOne a').tooltip()

		$("a.ajax").on("click",function(event) {
			event.preventDefault();
			$.get($(this).attr("href"), function(data) { 
				generatenoty("information", data);
			});
			$(this).toggleClass("on");
		});
    	
    	/*$( document ).tooltip({ position: { my: "right top", at: "right top", of: "body", collision: "fit" } });*/
		//$("#debugsettings").on("click","");
	});
</script>
</body>
</html>
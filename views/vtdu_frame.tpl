<!DOCTYPE html>
<html lang="en">
<head>
	<title>vt DevUtils 2</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.2/themes/black-tie/jquery-ui.css">
	<link rel="stylesheet" href="[{$oViewConf->getModuleUrl('vt-devutils','out/src/style.css') }]">
</head>
<body>
<div id="accordion">
	<h3>vt DevUtils</h3>

	<div>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=cleartmp&ajax=1" class="ajax" title="[{oxmultilang ident='vtdu_cleartmp'}]">
			<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/cleartmp.png")}]"/>
		</a>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearsmarty&ajax=1" class="ajax" title="[{oxmultilang ident='vtdu_clearsmarty'}]">
			<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearsmarty.png")}]"/>
		</a>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearphp&ajax=1" class="ajax" title="[{oxmultilang ident='vtdu_clearphp'}]">
			<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearphp.png")}]"/>
		</a>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearlang&ajax=1" class="ajax" title="[{oxmultilang ident='vtdu_clearlang'}]">
			<img id="" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/clearlang.png")}]"/>
		</a>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearconfig"><b>clear config cache only</b></a><br/>
		<div id="response1"></div>
	</div>
	<h3>Debug Settings</h3>

	<div>
		<div id="debugsettings">
			[{foreach from=$oView->getDebugSettings() key="key" item="val"}]
				<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=toggledebugsetting&setting=[{$key}]&ajax=1" class="ajax [{if $val}]on[{/if}]" title="[{oxmultilang ident='SHOP_MODULE_'|cat:$key}]">
					<img id="[{$key}]" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/")}]debugsetting_[{$key}][{if $val}]_on[{/if}].png"/>
				</a>
			[{/foreach}]
		</div>
	</div>
	<h3>Second one</h3>

	<div>Fusce sit amet sapien vitae justo pulvinar posuere quis in libero. Cras ut arcu vitae magna luctus pretium. Sed
		quis dolor in sem egestas interdum. Nunc pharetra auctor metus, eu sollicitudin nisl tincidunt in. Proin odio
		turpis, iaculis nec euismod nec, pharetra non augue. Lorem ipsum dolor sit amet, consectetur adipiscing elit.
		Nunc nulla ipsum, scelerisque non tempus non, dictum vel enim. Aliquam lobortis dolor sit amet massa ullamcorper
		quis egestas sapien egestas.
	</div>
	<h3>Third one</h3>

	<div>...</div>
</div>

<script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<script src="http://code.jquery.com/ui/1.10.2/jquery-ui.js"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/src/jquery.noty.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/src/jquery.noty.center.js")}]"></script>
<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/src/jquery.noty.default.js")}]"></script>
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
		$("#accordion").accordion({ heightStyle: "fill" });
		
		$("a.ajax").on("click",function(event) {
			event.preventDefault();
			$.get($(this).attr("href"), function(data) { 
				generatenoty("information", data);
			});
			$(this).toggleClass("on");
		});
    	
    	$( document ).tooltip({ position: { my: "right top", at: "right top", of: "body", collision: "fit" } });
		//$("#debugsettings").on("click","");
	});
</script>
</body>
</html>
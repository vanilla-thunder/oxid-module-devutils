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
		[{if $cleartmpmsg}]<strong style="color:red">[{$cleartmpmsg}]</strong><br/>[{/if}]
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=cleartmp"><b>clear whole tmp/</b></a><br/>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearsmarty"><b>clear template cache</b></a><br/>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearphp"><b>clear all php cache</b></a><br/>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearlang"><b>clear lang cache only</b></a><br/>
		<a href="[{$oViewConf->getSelfLink()}]&cl=vtdu&fnc=clearconfig"><b>clear config cache only</b></a><br/>

	</div>
	<h3>Debug Settings</h3>

	<div>
		<form name="debugsettings" action="[{ $oViewConf->getSelfLink() }]" method="post">
			<div id="debugsettings">
			[{foreach from=$oView->getDebugSettings() key="key" item="val"}]
				<p>
					<input type="hidden" name="[{$key}]" value="0" />
					<input type="checkbox" name="[{$key}]" id="[{$key}]" value="1" [{if $val}]checked="checked"[{/if}]/>
					<label for="[{$key}]" id="[{$key}]Label">[{oxmultilang ident="SHOP_MODULE_$key" }]</label>
				</p>
			[{/foreach}]
			</div>
		</form>
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
<script type="text/javascript">
	$(function () {
		$("#accordion").accordion({
			heightStyle: "fill"
		});
		$("#debugsettings input[type='checkbox']").button().on("click", function() {
			var label =  $(this).next("label");
			label.addClass("loading");
			//var postvarname =
			$.post("[{ $oViewConf->getSelfLink()|replace:'&amp;':'&'|cat:'cl=vtdu&fnc=updateDebugSettings' }]",{ varname: $(this).attr('name'), varvalue: $(this).is(':checked')}).done( function() { console.log(label); label.removeClass("loading"); });
		});
		//$("#debugsettings").on("click","");
	});
</script>
</body>
</html>
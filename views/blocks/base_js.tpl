[{$smarty.block.parent}]
<script>
	[{if $oViewConf->getVTdebugSetting("bShowCl")}]
		console.log("class: [{$oView->getClassName()}]");
	[{/if}]
	[{if $oViewConf->getVTdebugSetting("bShowTpl")}]
		console.log("template: [{$oView->getTemplateName()}]");
	[{/if}]
</script>
[{$smarty.block.parent}]
[{if $oViewConf->getActiveClassName() == "module_config" }]
	<form id="devutils" name="devutils" action="[{ $oViewConf->getSelfLink() }]" method="post">
		[{ $oViewConf->getHiddenSid() }]
		<input type="hidden" name="oxid" value="[{$oModule->getInfo('id')}]">
		<input type="hidden" name="cl" value="module_config">
		<input type="hidden" name="fnc" value="">
	</form>
	<li><a href="#" onClick="Javascript:document.devutils.fnc.value='resetModuleSettings';document.devutils.submit();">reset module settings</a> |</li>
	<li><a href="#" onClick="Javascript:document.devutils.fnc.value='resetModuleFiles';document.devutils.submit();">reset module files</a> |</li>
	<li><a href="#" onClick="Javascript:document.devutils.fnc.value='resetModuleTemplates';document.devutils.submit();">reset module templates</a> |</li>
	<li><a href="#" onClick="Javascript:document.devutils.fnc.value='resetTemplateBlocks';document.devutils.submit();">reset template blocks</a></li>
[{/if}]
[{if $message}]<script>console.log("[{$message}]");</script>[{/if}]
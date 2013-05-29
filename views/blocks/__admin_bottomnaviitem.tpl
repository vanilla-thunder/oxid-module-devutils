[{$smarty.block.parent}]
[{* $if $oView->getClassName() *}]
<div id="vtduframe">
    <iframe src="[{ $oViewConf->getSelfLink()|replace:'&amp;':'&'|oxaddparams:'cl=vtdu'}]"/></iframe>
</div>
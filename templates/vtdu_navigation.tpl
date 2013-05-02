[{include file="navigation.tpl"}]
[{* $if $oView->getClassName() *}]
<style type="text/css">
    #vtduframe {
        width: 200px;
        height: 300px;
        margin-left: 0;
        position: fixed;
        bottom: 100px;
        left: -200px;
        -webkit-transition:all 1s ease;
        -moz-transition:all 1s ease;
		background: white;
    }
    #vtduframe iframe {
        width: 198px;
        height: 298px;
        border: 1px solid black;
    }
    #vtduframe:hover{
        margin-left:200px;
    }
    #vtduicon {
        position: absolute;
        bottom: 0;
        right: -40px;
        z-index: 999;
        width: 30px;
        height: 30px;
        padding: 5px;
    }
</style>
<div id="vtduframe">
    <iframe src="[{ $oViewConf->getSelfLink()|replace:'&amp;':'&'|oxaddparams:'cl=vtdu'}]"/></iframe>
    <img id="vtduicon" src="[{$oViewConf->getModuleUrl("vt-devutils","out/vtduicon.png")}]"/>
</div>
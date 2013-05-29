[{include file="navigation.tpl"}]
[{* $if $oView->getClassName() *}]
<style type="text/css">
    #vtduframe {
        width: 201px;
        height: 300px;
        margin-top: -150px;
        margin-left: 0;
        position: fixed;
        bottom: 80px;
        left: -195px;
        -webkit-transition:all 1s ease;
        -moz-transition:all 1s ease;
    }
    #vtduframe iframe {
        width: 199px;
        height: 298px;
        border: 1px solid black;
    }
    #vtduframe:hover{
        margin-left:195px;
    }
    #vtduicon {
        position: absolute;
        bottom: 0%;
        right: -40px;
        z-index: 999;
        width: 30px;
        height: 30px;
        padding: 5px;
        border: 1px solid black;
        border-left: 0;
    }
</style>
<div id="vtduframe">
    <iframe src="[{ $oViewConf->getSelfLink()|replace:'&amp;':'&'|oxaddparams:'cl=vtdu'}]"/></iframe>
    <img id="vtduicon" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/vtduicon.png")}]"/>
</div>
[{include file="navigation.tpl"}]
[{* $if $oView->getClassName() *}]
<style type="text/css">
    #vtduframe {
        width: 200px;
        height: 200px;
        margin-top: -150px;
        margin-left: 0;
        position: fixed;
        bottom: 80px;
        left: -198px;
        -webkit-transition:all 1s ease;
        -moz-transition:all 1s ease;
    }
    #vtduframe iframe {
        width: 200px;
        height: 200px;
        border: 0;
    }
    #vtduframe:hover{
        margin-left:199px;
    }
    #vtduicon {
        position: absolute;
        bottom: 0%;
        right: -41px;
        z-index: 999;
        width: 30px;
        height: 30px;
        padding: 5px;
        border: 1px solid black;
    }
</style>
<div id="vtduframe">
    <iframe src="[{ $oViewConf->getSelfLink()|replace:'&amp;':'&'|oxaddparams:'cl=vtdu_be'}]"/></iframe>
    <img id="vtduicon" src="[{$oViewConf->getModuleUrl("vt-devutils","out/icons/vtduicon.png")}]"/>
</div>
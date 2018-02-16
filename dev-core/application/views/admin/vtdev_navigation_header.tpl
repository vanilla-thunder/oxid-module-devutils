<style type="text/css">
    .btn-vtdev {
        float: left;
        width: 100px;
        height: 53px;
        text-align: center;
        margin: 0;
        padding: 0 10px;
        border: 0;
        border-right: 1px solid #6a6c6f;
        background: deepskyblue;
        color: #fff;
        cursor: pointer;
    }

    .btn-vtdev:hover {
        background: dodgerblue;
    }

    #keepalive {
        display: none;
    }

    #keepalive:checked + .btn-vtdev {
        background: #00AA00;
    }
</style>
<form name="vtdevutils" id="vtdevutils" action="[{$oViewConf->getSelfLink() }]" method="post" target="vtdevframe">
    [{$oViewConf->getHiddenSid() }]
    <input type="hidden" name="cl" value="vtdev_gui">
    <input type="checkbox" id="keepalive" name="fnc" value="keepalive">
    <button class="btn-vtdev">
        <label for="keepalive">
            keep me<br/>logged in
        </label>
    </button>
    <button class="btn-vtdev" type="submit" name="fnc" value="cleartmp">clear<br/>php cache</button>
    <button class="btn-vtdev" type="submit" name="fnc" value="cleartpl">clear<br/>tpl cache</button>

    <iframe name="vtdevframe" width="0" height="0" border="0" style="display:none;"></iframe>
    [{* <button class="textButton" type="submit" name="fnc" value="updateviews" onclick="return confirm('[{oxmultilang ident="SHOP_MALL_UPDATEVIEWSCONFIRM"}]?')">update views</button> *}]
</form>
<script>
    setInterval(function(){
        var vtdevutils = document.getElementById('vtdevutils'),
            keepalive = document.getElementById('keepalive');
        if(keepalive.checked) vtdevutils.submit();
    }, 300000);
</script>
[{include file="header.tpl"}]

<style type="text/css">
   .btn-vtdev {
      float: left;
      width: 100px;
      height: 53px;
      text-align: center;
      margin: 0; padding: 0 10px;
      border: 0; border-right: 1px solid #6a6c6f;
      background: deepskyblue; color: #fff;
      cursor: pointer;
   }
   .btn-vtdev:hover {
      background: dodgerblue;
   }
</style>
<form name="vtdevutils" action="[{$oViewConf->getSelfLink() }]" method="post" target="vtdevframe">
   [{$oViewConf->getHiddenSid() }]
   <input type="hidden" name="cl" value="vtdev_gui">
   <button class="btn-vtdev" type="submit" name="fnc" value="cleartmp">clear<br/>php cache</button>
   <button class="btn-vtdev" type="submit" name="fnc" value="cleartpl">clear<br/>tpl cache</button>
   <iframe name="vtdevframe" width="0" height="0" border="0" style="display:none;"></iframe>
   [{* <button class="textButton" type="submit" name="fnc" value="updateviews" onclick="return confirm('[{oxmultilang ident="SHOP_MALL_UPDATEVIEWSCONFIRM"}]?')">update views</button> *}]
</form>
[{include file="header.tpl"}]
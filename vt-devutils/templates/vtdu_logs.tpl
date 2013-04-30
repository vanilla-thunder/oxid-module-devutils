<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
  <head>
	<title>Category Banner</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<meta http-equiv="X-UA-Compatible" value="IE=edge" />
	[{if isset($meta_refresh_sec,$meta_refresh_url) }]
	  <meta http-equiv=Refresh content="[{$meta_refresh_sec}];URL=[{$meta_refresh_url|replace:"&amp;":"&"}]" />
	[{/if}]

	<link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]main.css" />
	<link rel="stylesheet" href="[{$oViewConf->getResourceUrl()}]colors.css" />
	<link rel="stylesheet" type="text/css" href="[{$oViewConf->getResourceUrl()}]yui/build/assets/skins/sam/container.css" />
  </head>
  <body>
	<div class="[{$box|default:'box'}]" style="[{if !$box && !$bottom_buttons}]height: 98%;[{/if}]">
	  <h1>exception log</h1>
	  <pre>[{$ExceltionLog}]</pre>

	  <h1>Webserver Error Log ([{$oView->getErrorLog()|@count}])</h1>
	  <table border="0" style="border-collapse:collapse">
		[{foreach from=$oView->getErrorLog() item="error"}]
		  [{$error|var_dump}]<hr/>
		  [{*
		  <tr><td>[{$error.0}]</td><td>[{$error.1}]</td><td>[{$error.2}]</td></tr>
		  <tr><td colspan="3">[{$error.3}]</td></tr>
		  <tr><td colspan="3"><hr/></td></tr>
		  *}]
		  
		[{/foreach}]
	  </table>
	  <hr/>
	  <script type="text/javascript">
		if (typeof jQuery == 'undefined') {
		  document.write('<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.7.2/jquery.min.js"></' + 'script>');
		}
	  </script>
	  <script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js"></script> [{* jQuery UI for datapickers and mCustomScrollbar *}]
	  <script type="text/javascript" src="http://cdn.jquerytools.org/1.2.7/all/jquery.tools.min.js"></script> [{* jQuery TOOLS for tooltip *}]
	  <script type="text/javascript">
		$(document).ready(function() {

		});
	  </script> 


	</div>
	[{include file="bottomitem.tpl"}]

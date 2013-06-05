<!DOCTYPE html>
<html lang="en">
	<head>
		<title>vt DevUtils 2</title>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">

		<link rel="stylesheet" media="screen" href="[{$oViewConf->getModuleUrl('vt-devutils','out/css/bootstrap.min.css') }]">
		<link rel="stylesheet" media="screen" href="[{$oViewConf->getModuleUrl('vt-devutils','out/css/bootstrap-responsive.min.css') }]">
		<link rel="stylesheet" media="screen" href="[{$oViewConf->getModuleUrl('vt-devutils','out/css/vt-devutils.css') }]?[{$smarty.now}]">
	</head>
	<body>
		<div class="container fullheight">
			<div class="row">
				[{if $ExLog}]
					<div class="span6 log">
						<h2>exception log</h2><hr/>
						[{foreach from=$ExLog item=ex}]
							[{$ex|var_dump}]<hr/>
						[{/foreach}]
					</div>
				[{/if}]
				[{if $SrvErrLog}]
					<div class="span6 log">
						<h2>webserver error log</h2><hr/>
						[{$SrvErrLog}]
					</div>
				[{/if}]
			</div>
			<div class="row">
				[{if $SqlLog}]
					<div class="span6 log">
						<h2>MySQL log</h2><hr/>
						[{$SqlLog}]
					</div>
				[{/if}]
				[{if $MailLog}]
					<div class="span6 log">
						<h2>mail log</h2><hr/>
						[{$MailLog}]
					</div>
				[{/if}]
			</div>

		</div>

		<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery-1.9.1.js")}]"></script>
		<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/bootstrap.min.js")}]"></script>
		<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.js")}]"></script>
		<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.center.js")}]"></script>
		<script src="[{$oViewConf->getModuleUrl("vt-devutils","out/js/jquery.noty.default.js")}]"></script>
		<script type="text/javascript">
			$(document).ready(function () {

			});
		</script>


	</body>
</html>

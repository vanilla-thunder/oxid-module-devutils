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
		<div class="container-fluid">
			<div class="row-fluid">
				[{if $ExLog}]
					<div class="span6 log">
						<h2  class="text-center">exception log</h2>
						<div class="accordion" id="exceptionlog">
							[{foreach from=$ExLog item=ex name=exlog}]
								<div class="accordion-group">
									<div id="exception[{$smarty.foreach.exlog.iteration}]" class="accordion-body collapse [{if $smarty.foreach.exlog.last}]in[{/if}]">
										<pre class="accordion-inner">[{$ex->text}]</pre>
									</div>
									<div class="accordion-heading">
										<a class="accordion-toggle" data-toggle="collapse" data-parent="#exceptionlog" href="#exception[{$smarty.foreach.exlog.iteration}]">
											[{$ex->header}]
										</a>
									</div>
								</div>
							[{/foreach}]
						</div>
					</div>
				[{/if}]

				[{if $SrvErrLog}]
					<div class="span6 log">
						<h2  class="text-center">webserver error log</h2>
						<table class="table table-striped table-condensed">
							[{foreach from=$SrvErrLog item=log}]
								<tr style="margin-top: 5px;">
									<th>[{$log->date}]</th>
									<th>[{$log->type}]</th>
									<th>[{$log->client}]</th>
								</tr>
								<tr class="[{$log->type}]">
									<td colspan="3">[{$log->text}]</td>
								</tr>
							[{/foreach}]
						</table>
					</div>
				[{/if}]
				[{if $SqlLog}]
					<div class="span6 log">
						<h2  class="text-center">MySQL log</h2>
						<table class="table table-striped">
							…
						</table>
						[{$SqlLog}]
					</div>
				[{/if}]
				[{if $MailLog}]
					<div class="span6 log">
						<h2>mail log</h2>
						<hr/>
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

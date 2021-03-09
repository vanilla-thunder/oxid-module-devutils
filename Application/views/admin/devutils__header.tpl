<!DOCTYPE html>
<html lang="en">
<head>
    <title>[vt] DevUtils</title>
    <meta name="description" content="">
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">
    [{oxstyle include=$oViewConf->getModuleUrl("vt-devutils","out/css/materialize.min.css")}]
    [{oxstyle include=$oViewConf->getModuleUrl("vt-devutils","out/css/devutils.css") }]
    [{oxstyle include=$oViewConf->getModuleUrl("vt-devutils","out/css/ng-sortable.css") }]
    [{oxstyle}]
</head>
<body ng-app="devApp" ng-controller="devCtrl" id="[{$oView->getClassName()}]">
<div class="container">
<!DOCTYPE html>
<html lang="en">
<head>
    <title>[vt] Dev Utils</title>    
    <meta name="description" content="">
    
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0">

    <link rel="stylesheet" type="text/css" href="[{$oViewConf->getModuleUrl("_dev-core","out/libs/lumx/dist/lumx.css")}]"/>
    [{* <link rel="stylesheet" type="text/css" href="[{$oViewConf->getModuleUrl("_dev-core","src/fontawesome/css/font-awesome.min.css")}]"/> *}]
    <link rel="stylesheet" type="text/css" href="[{$oViewConf->getModuleUrl("_dev-core","out/libs/mdi/css/materialdesignicons.min.css")}]"/>
    <link rel="stylesheet" type="text/css" href="[{$oViewConf->getModuleUrl("_dev-core","out/devutils.css")}]?v=[{$smarty.now}]"/>
</head>
<body ng-app="devApp" ng-controller="devCtrl">
    [{capture name=appdep}]'lumx','ngClipboard','masonry'[{/capture}]

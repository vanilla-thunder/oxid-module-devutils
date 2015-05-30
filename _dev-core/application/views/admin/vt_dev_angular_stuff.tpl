.config(function($mdThemingProvider) { 
    $mdThemingProvider.theme('devutils').primaryPalette('blue').accentPalette('green').warnPalette('red').backgroundPalette('grey');
    $mdThemingProvider.setDefaultTheme('devutils');
})
.filter("html", ['$sce', function ($sce) { return function(htmlCode) { return $sce.trustAsHtml(htmlCode); } }])
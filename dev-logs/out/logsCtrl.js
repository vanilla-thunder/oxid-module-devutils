app.controller("consoleCtrl", function($scope, $http)
    {
        $scope.runCode = function() {
            $http({
                method  : 'POST',
                url     : 'process.php',
                data    : $.param($scope.formData),  // pass in data as strings
                headers : { 'Content-Type': 'application/x-www-form-urlencoded' }  // set the headers so angular passing info as form data (not request payload)
            });
        };
    }
);
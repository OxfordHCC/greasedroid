var app = angular.module('billing', []);

// fix jinja
app.config(['$interpolateProvider',
    function($interpolateProvider) {
        $interpolateProvider.startSymbol('[[');
        $interpolateProvider.endSymbol(']]');
}]);

app.controller('currentCardCtrl', ["$scope",
                            function($scope) {
    // some basic debugging
    console.log("controller");
    console.dir($scope);

    $scope.change = false;

    $scope.changeCreditCard = function(lastChange) {
        $scope.change = true;
        console.log("trying to change CC!");
    };
}]);

// prototype controller
app.controller('billingFrmCtrl', ["$scope",
                            function($scope) {
    // some basic debugging
    console.log("controller");
    console.dir($scope);
    $scope.actions = [];

    $scope.saveCreditCard = function(cc) {
        $scope.actions.push({"action": "saved", "data": cc});
    }
}]);


var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$controller', 'Job',
  function ($scope, $controller, Job) {

    $controller('MainCtrl', { $scope: $scope });
    
    $scope.jobs = Job.query();
  }
]);

JobsControllers.controller('JobsShowCtrl', [
  '$scope', '$controller', '$routeParams', 'Job',
  function ($scope, $controller, $routeParams, Job) {

    $controller('MainCtrl', { $scope: $scope });

    var jobId = $routeParams.id;
    $scope.job = Job.get({id: jobId});
  }
]);
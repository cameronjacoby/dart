var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$controller', 'Job',
  function ($scope, $controller, Job) {

    $controller('MainCtrl', { $scope: $scope });
    
    $scope.jobs = Job.query();
    $scope.filteredJobs = [];

    $scope.searchedRoles = [];
    $scope.searchedLocs = [];
    $scope.allSearches = [];

    $scope.addRoleToSearch = function (role) {
      if ($scope.searchedRoles.indexOf(role) === -1) {
        $scope.searchedRoles.push(role);
        $scope.allSearches.push(role);
        filter();
      }
    };

    $scope.addLocToSearch = function (loc) {
      if ($scope.searchedLocs.indexOf(loc) === -1) {
        $scope.searchedLocs.push(loc);
        $scope.allSearches.push(loc);
        filter();
      }
    };

    // helper function to filter jobs by searched roles and locations
    var filter = function() {
      console.log($scope.searchedRoles);
      console.log($scope.searchedLocs);
      console.log($scope.allSearches);
      
      $scope.filteredJobs = [];
        
      angular.forEach($scope.jobs, function (job) {
        var roleMatch = false;
        var locMatch = false;
        
        if ($scope.searchedRoles.length > 0) {
          angular.forEach(job.roles, function (role) {
            if ($scope.searchedRoles.indexOf(role.slug) > -1) {
              roleMatch = true;
            }
          });
        } else {
          roleMatch = true;
        }

        if ($scope.searchedLocs.length > 0) {
          angular.forEach(job.locations, function (loc) {
            if ($scope.searchedLocs.indexOf(loc.slug) > -1) {
              locMatch = true;
            }
          });
        } else {
          locMatch = true;
        }
        
        if (roleMatch && locMatch && $scope.filteredJobs.indexOf(job) === -1) {
          $scope.filteredJobs.push(job);
        }
      });

      console.log($scope.filteredJobs.length);
    };
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
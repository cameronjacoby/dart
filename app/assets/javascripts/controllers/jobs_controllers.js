var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$controller', 'Job', 'Role', 'Location',
  function ($scope, $controller, Job, Role, Location) {

    $controller('MainCtrl', { $scope: $scope });

    var allJobs = [];
    $scope.jobs = [];

    Job.query(function (jobs) {
      allJobs = jobs;
      $scope.jobs = jobs;
    });

    $scope.roles = Role.query();
    $scope.locations = Location.query();

    var searchedRoles = [];
    var searchedLocs = [];
    $scope.allSearches = [];

    $scope.addRoleToSearch = function (role) {
      if (searchedRoles.indexOf(role.slug) === -1) {
        searchedRoles.push(role.slug);
        $scope.allSearches.push(role);
        filter();
      }
    };

    $scope.addLocToSearch = function (loc) {
      if (searchedLocs.indexOf(loc.slug) === -1) {
        searchedLocs.push(loc.slug);
        $scope.allSearches.push(loc);
        filter();
      }
    };

    // helper function to filter jobs by searched roles and locations
    var filter = function() {
      console.log(searchedRoles);
      console.log(searchedLocs);
      
      var filteredJobs = [];
      console.log('$scope.jobs', $scope.jobs.length);
      console.log('filteredJobs', filteredJobs.length);

      $scope.filtering = true;
        
      angular.forEach(allJobs, function (job) {
        var roleMatch = false;
        var locMatch = false;
        
        if (searchedRoles.length > 0) {
          angular.forEach(job.roles, function (role) {
            if (searchedRoles.indexOf(role.slug) > -1) {
              roleMatch = true;
            }
          });
        } else {
          roleMatch = true;
        }

        if (searchedLocs.length > 0) {
          angular.forEach(job.locations, function (loc) {
            if (searchedLocs.indexOf(loc.slug) > -1) {
              locMatch = true;
            }
          });
        } else {
          locMatch = true;
        }
        
        if (roleMatch && locMatch && filteredJobs.indexOf(job) === -1) {
          filteredJobs.push(job);
        }
      });

      $scope.jobs = filteredJobs;

      console.log('$scope.jobs', $scope.jobs.length);
      console.log('filteredJobs', filteredJobs.length);
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
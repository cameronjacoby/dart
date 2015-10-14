var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$rootScope', '$controller', 'Job', 'Role', 'Location',
  function ($scope, $rootScope, $controller, Job, Role, Location) {

    $controller('MainCtrl', { $scope: $scope });

    var allJobs = [];
    $scope.jobs = [];

    Job.query(function (jobs) {
      allJobs = jobs;
      if ($rootScope.currentUser) {
        var savedJobs = $rootScope.currentUser.jobs;
        for (var i = 0; i < allJobs.length; i += 1) {
          for (var j = 0; j < savedJobs.length; j += 1) {
            if (allJobs[i].guid === savedJobs[j].guid) {
              allJobs[i].bookmarked = true;
            }
          }
        }
      }
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
  '$scope', '$rootScope', '$controller', '$routeParams', 'Job',
  function ($scope, $rootScope, $controller, $routeParams, Job) {

    $controller('MainCtrl', { $scope: $scope });

    var jobId = $routeParams.id;
    
    Job.get({id: jobId}, function (job) {
      $scope.job = job;
      if ($rootScope.currentUser) {
        var savedJobs = $rootScope.currentUser.jobs;
        for (var i = 0; i < savedJobs.length; i += 1) {
          if ($scope.job.guid === savedJobs[i].guid) {
            $scope.job.bookmarked = true;
          }
        }
      }
    });
  }
]);
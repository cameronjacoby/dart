var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$controller', 'Job',
  function ($scope, $controller, Job) {

    $controller('MainCtrl', { $scope: $scope });
    
    $scope.jobs = Job.query();
    $scope.filteredJobs = [];

    var searchedCats = [];
    var searchedLocs = [];

    $scope.addCatToSearch = function (cat) {
      if (searchedCats.indexOf(cat) === -1) {
        searchedCats.push(cat);
        filter();
      }
    };

    $scope.addLocToSearch = function (loc) {
      if (searchedLocs.indexOf(loc) === -1) {
        searchedLocs.push(loc);
        filter();
      }
    };

    var filter = function() {
      console.log(searchedCats);
      console.log(searchedLocs);
      
      $scope.filteredJobs = [];
        
      angular.forEach($scope.jobs, function (job) {
        var catMatch = false;
        var locMatch = false;
        
        if (searchedCats.length > 0) {
          angular.forEach(job.categories, function (cat) {
            if (searchedCats.indexOf(cat.slug) > -1) {
              catMatch = true;
            }
          });
        } else {
          catMatch = true;
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
        
        if (catMatch && locMatch && $scope.filteredJobs.indexOf(job) === -1) {
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
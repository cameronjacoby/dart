var JobsControllers = angular.module('JobsControllers', []);

JobsControllers.controller('JobsIndexCtrl', [
  '$scope', '$controller', 'Job',
  function ($scope, $controller, Job) {

    $controller('MainCtrl', { $scope: $scope });
    
    $scope.jobs = Job.query();
    $scope.filteredJobs = [];

    $scope.searchedCats = [];
    $scope.searchedLocs = [];
    $scope.allSearches = [];

    $scope.addCatToSearch = function (cat) {
      if ($scope.searchedCats.indexOf(cat) === -1) {
        $scope.searchedCats.push(cat);
        $scope.allSearches.push(cat);
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

    // helper function to filter jobs by searched categories and locations
    var filter = function() {
      console.log($scope.searchedCats);
      console.log($scope.searchedLocs);
      console.log($scope.allSearches);
      
      $scope.filteredJobs = [];
        
      angular.forEach($scope.jobs, function (job) {
        var catMatch = false;
        var locMatch = false;
        
        if ($scope.searchedCats.length > 0) {
          angular.forEach(job.categories, function (cat) {
            if ($scope.searchedCats.indexOf(cat.slug) > -1) {
              catMatch = true;
            }
          });
        } else {
          catMatch = true;
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
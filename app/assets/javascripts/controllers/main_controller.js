var MainController = angular.module('MainController', []);

MainController.controller('MainCtrl', [
  '$rootScope', '$location', '$auth', 'User', 'toastr',
  function ($rootScope, $location, $auth, User, toastr) {

    $rootScope.date = new Date();

    User.currentUser()
      .then(function(response) {
        $rootScope.currentUser = response.data;
        var savedJobs = $rootScope.currentUser.jobs;
        for (var i = 0; i < savedJobs.length; i += 1) {
          savedJobs[i].bookmarked = true;
        }
      });
    
    $rootScope.isAuthenticated = function() {
      return $auth.isAuthenticated();
    };

    $rootScope.logout = function() {
      if (!$auth.isAuthenticated()) { return; }
      $auth.logout()
        .then(function() {
          $location.path('/login');
          toastr.info('Successfully logged out');
        });
    };
  }
]);

MainController.config(function(toastrConfig) {
  angular.extend(toastrConfig, {
    closeButton: true,
    extendedTimeOut: 5000
  });
});
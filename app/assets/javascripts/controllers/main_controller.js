var MainController = angular.module('MainController', []);

MainController.controller('MainCtrl', [
  '$rootScope', '$location', '$auth', 'User', 'toastr',
  function ($rootScope, $location, $auth, User, toastr) {

    User.currentUser()
      .then(function(response) {
         $rootScope.currentUser = response.data;
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
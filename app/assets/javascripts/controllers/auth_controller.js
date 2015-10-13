var AuthController = angular.module('AuthController', []);

AuthController.controller('AuthCtrl', [
  '$scope', '$controller', '$location', '$auth', 'toastr',
  function ($scope, $controller, $location, $auth, toastr) {

    $controller('MainCtrl', { $scope: $scope });

    if ($auth.isAuthenticated()) {
      $location.path('/');
      return;
    }

    $scope.signup = function() {
      $auth.signup($scope.user)
        .then(function(response) {
          $auth.setToken(response.data.token, $location.path('/'));
          toastr.info('Successfully signed up');
        })
        .catch(function(response) {
          $scope.user = {};
          toastr.error(response.data.errors || response.statusText);
        });
    };

    $scope.login = function() {
      $auth.login($scope.user)
        .then(function(response) {
          $location.path('/');
          toastr.info('Successfully logged in');
        })
        .catch(function(response) {
          $scope.user = {};
          toastr.error(response.data.errors || response.statusText);
        });
    };

    $scope.authenticate = function(provider) {
      $auth.authenticate(provider)
        .then(function(response) {
          $location.path('/');
          toastr.info('Successfully signed in with ' + provider.charAt(0).toUpperCase() + provider.substring(1));
        })
        .catch(function(response) {
          toastr.error(response.data.errors || response.statusText);
        });
    };
  }
]);

AuthController.config(function($authProvider) {
  $authProvider.linkedin({
    clientId: '75aoposx0c56tq'
  });

  $authProvider.github({
    clientId: '1416f3ece765ca3fd9e0'
  });
});
var BookmarksController = angular.module('BookmarksController', []);

BookmarksController.controller('BookmarksCtrl', [
  '$scope', '$controller', '$location', '$auth',
  function ($scope, $controller, $location, $auth) {

    $controller('MainCtrl', { $scope: $scope });

    if (!$auth.isAuthenticated()) {
      $location.path('/login');
      return;
    }
  }
]);
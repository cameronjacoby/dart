var UsersServices = angular.module('UsersServices', []);

UsersServices.factory('User', ['$http', function ($http) {
  return {
    currentUser: function() {
      return $http.get('/api/users/current');
    }
  };
}]);
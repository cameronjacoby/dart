var Services = angular.module('Services', []);

Services.factory('Job', ['$resource', function ($resource) {
  return $resource('/api/jobs/:id', { id: '@id' });
}]);

Services.factory('Role', ['$resource', function ($resource) {
  return $resource('/api/roles/:id', { id: '@id' });
}]);

Services.factory('Location', ['$resource', function ($resource) {
  return $resource('/api/locations/:id', { id: '@id' });
}]);

Services.factory('User', ['$http', function ($http) {
  return {
    currentUser: function() {
      return $http.get('/api/users/current');
    }
  };
}]);
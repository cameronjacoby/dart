var JobsServices = angular.module('JobsServices', []);
  
JobsServices.factory('Job', ['$resource', function ($resource) {
  return $resource('/api/jobs/:id', { id: '@id' });
}]);
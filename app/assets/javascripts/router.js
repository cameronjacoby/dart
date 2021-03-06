var Router = angular.module('Router', []);

Router.config(['$routeProvider', '$locationProvider', function ($routeProvider, $locationProvider) {
  $routeProvider
    .when('/', {
      templateUrl: 'jobs/index.html',
      controller: 'JobsIndexCtrl'
    })
    .when('/jobs/:id', {
      templateUrl: 'jobs/show.html',
      controller: 'JobsShowCtrl'
    })
    .when('/signup', {
      templateUrl: 'auth/signup.html',
      controller: 'AuthCtrl'
    })
    .when('/login', {
      templateUrl: 'auth/login.html',
      controller: 'AuthCtrl'
    })
    .when('/bookmarks', {
      templateUrl: 'users/bookmarks.html',
      controller: 'BookmarksCtrl'
    })
    .otherwise({
      redirectTo: '/'
    });

  $locationProvider.html5Mode({
    enabled: true,
    requireBase: false
  });
}]);
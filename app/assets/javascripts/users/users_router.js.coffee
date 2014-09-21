class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider
      .when "/register",
        templateUrl: "/user_templates/new",
        controller: "UsersNewCtrl as newUser"

    @locationProvider.html5Mode(true)

UsersRouter = angular.module("UsersRouter", [
  "ngRoute"
])

UsersRouter.config(["$routeProvider", "$locationProvider", Router])

UsersRouter.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $('meta[name=csrf-token]').attr("content")
])
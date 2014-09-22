class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider
      .when "/login",
        templateUrl: "/session_templates/new",
        controller: "SessionCtrl as session"

    @locationProvider.html5Mode(true)

SessionRouter = angular.module("SessionRouter", [
  "ngRoute"
])

SessionRouter.config(["$routeProvider", "$locationProvider", Router])

SessionRouter.config ["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $("meta[name=csrf-token]").attr("content")
]
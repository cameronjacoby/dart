class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider
      .when "/seekers/:id",
        templateUrl: "/seeker_templates/show",
        controller: "SeekersShowCtrl as seeker"

    @locationProvider.html5Mode(true)

SeekersRouter = angular.module("SeekersRouter", [
  "ngRoute"
])

SeekersRouter.config(["$routeProvider", "$locationProvider", Router])

SeekersRouter.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $('meta[name=csrf-token]').attr("content")
])
class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider.
      when "/",
        templateUrl: "/job_templates",
        controller: "JobsCtrl as jobs"

    @locationProvider.html5Mode(true)

JobsRouter = angular.module("JobsRouter", [
  "ngRoute"
])

JobsRouter.config(["$routeProvider", "$locationProvider", Router])

JobsRouter.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $('meta[name=csrf-token]').attr("content")
])
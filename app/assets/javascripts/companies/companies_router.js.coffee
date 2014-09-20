class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider
      .when "/companies/:id",
        templateUrl: "/company_templates/show",
        controller: "CompaniesShowCtrl as company"

    @locationProvider.html5Mode(true)

CompaniesRouter = angular.module("CompaniesRouter", [
  "ngRoute"
])

CompaniesRouter.config(["$routeProvider", "$locationProvider", Router])

CompaniesRouter.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $('meta[name=csrf-token]').attr("content")
])
class Router

  constructor: (@routeProvider, @locationProvider) ->

    @routeProvider
      .when "/skills/:id",
        templateUrl: "/skill_templates/show",
        controller: "SkillsShowCtrl as skill"

    @locationProvider.html5Mode(true)

SkillsRouter = angular.module("SkillsRouter", [
  "ngRoute"
])

SkillsRouter.config(["$routeProvider", "$locationProvider", Router])

SkillsRouter.config(["$httpProvider", ($httpProvider) ->
  $httpProvider.defaults.headers.common["X-CSRF-Token"] = $('meta[name=csrf-token]').attr("content")
])
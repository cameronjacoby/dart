SkillsControllers = angular.module("SkillsControllers", [])

class SkillsShowCtrl
  
  constructor: (@scope, @http, @routeParams) ->
    @http.get("/skills/#{@routeParams.id}.json").success (data) =>
      @skill = data
    @http.get("/skills.json").success (data) =>
      @skills = data

SkillsControllers.controller("SkillsShowCtrl", ["$scope", "$http", "$routeParams", SkillsShowCtrl])
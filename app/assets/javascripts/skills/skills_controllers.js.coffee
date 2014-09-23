SkillsControllers = angular.module("SkillsControllers", [])

class SkillsShowCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/skills/#{@routeParams.id}.json")
    .success (data) =>
      @skill = data
    @http.get("/skills.json")
    .success (data) =>
      @skills = data

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

SkillsControllers.controller("SkillsShowCtrl", SkillsShowCtrl)
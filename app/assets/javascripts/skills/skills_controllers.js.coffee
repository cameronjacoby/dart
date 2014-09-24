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

      if @rootScope.currentUser && @rootScope.currentUser.is_seeker
        i = 0
        while i < @skill.jobs.length
          j = 0
          while j < @rootScope.currentUser.seeker.jobs.length
            if @skill.jobs[i].id == @rootScope.currentUser.seeker.jobs[j].id
              @skill.jobs[i].favorited = true
            j += 1
          i += 1

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

SkillsControllers.controller("SkillsShowCtrl", SkillsShowCtrl)
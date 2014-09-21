JobsControllers = angular.module("JobsControllers", [])

class JobsCtrl
  
  constructor: (@scope, @http) ->
    @http.get("/jobs.json").success (data) =>
      @jobs = data
      @http.get("/skills.json").success (data) =>
        @skills = data

JobsControllers.controller("JobsCtrl", ["$scope", "$http", JobsCtrl])

class JobsShowCtrl
  
  constructor: (@scope, @http, @routeParams, @location) ->
    @http.get("/companies/#{@routeParams.company_id}/jobs/#{@routeParams.id}.json").success (data) =>
      if data == ""
        @location.path("/")
      else
        @job = data

JobsControllers.controller("JobsShowCtrl", ["$scope", "$http", "$routeParams", "$location", JobsShowCtrl])
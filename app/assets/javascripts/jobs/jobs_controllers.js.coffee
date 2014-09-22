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

  editJob: () ->
    skills = []
    i = 0
    while i < @job.skills.length
      skills.push @job.skills[i].name
      i += 1
    @job.skill_names = skills.join(", ")
    @updateMsg = false
    @editForm = true

  updateJob: () ->
    @http.put("/companies/#{@job.company_id}/jobs/#{@job.id}.json", {job: @job}).success (data) =>
      console.log "UPDATED!!!"
      @updateMsg = true
      @editForm = false

  deleteJob: () ->
    conf = confirm "Are you sure you want to delete this job?"
    if conf
      @http.delete("/companies/#{@job.company_id}/jobs/#{@job.id}.json").success (data) =>
        @location.path("/companies/#{@job.company_id}")

JobsControllers.controller("JobsShowCtrl", ["$scope", "$http", "$routeParams", "$location", JobsShowCtrl])
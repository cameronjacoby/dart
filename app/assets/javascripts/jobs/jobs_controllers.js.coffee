JobsControllers = angular.module("JobsControllers", [])

class JobsCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/jobs.json").success (data) =>
      @jobs = data
    @http.get("/skills.json").success (data) =>
      @skills = data

  @$inject = ["$scope", "$http", "$rootScope", "$location"]

JobsControllers.controller("JobsCtrl", JobsCtrl)

class JobsShowCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)
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

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

JobsControllers.controller("JobsShowCtrl", JobsShowCtrl)
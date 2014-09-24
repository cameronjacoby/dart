JobsControllers = angular.module("JobsControllers", [])

class JobsCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/jobs.json")
    .success (data) =>
      @jobs = data
      @http.get("/skills.json")
      .success (data) =>
        @skills = data

      if @rootScope.currentUser && @rootScope.currentUser.is_seeker
        i = 0
        while i < @jobs.length
          j = 0
          while j < @rootScope.currentUser.seeker.jobs.length
            if @jobs[i].id == @rootScope.currentUser.seeker.jobs[j].id
              @jobs[i].favorited = true
            j += 1
          i += 1

  exitDeleteMsg: () ->
    @rootScope.deleteMsg = false

  exitFilterForm: () ->
    @showFilter = false

  @$inject = ["$scope", "$http", "$rootScope", "$location"]

JobsControllers.controller("JobsCtrl", JobsCtrl)

class JobsShowCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/companies/#{@routeParams.company_id}/jobs/#{@routeParams.id}.json")
    .success (data) =>
      @job = data
      if @rootScope.currentUser && @rootScope.currentUser.is_seeker
        i = 0
        while i < @rootScope.currentUser.seeker.jobs.length
          if @job.id == @rootScope.currentUser.seeker.jobs[i].id
            @job.favorited = true
          i += 1

    .error () =>
      @location.path("/")

  exitUpdateMsg: () ->
    @updateMsg = false

  exitEditForm: () ->
    @editForm = false

  editJob: () ->
    if !@job.skill_names
      skills = []
      i = 0
      while i < @job.skills.length
        skills.push @job.skills[i].name
        i += 1
      @job.skill_names = skills.join(", ")
    @updateMsg = false
    @editForm = true

  updateJob: () ->
    @http.put("/companies/#{@job.company_id}/jobs/#{@job.id}.json", {job: @job})
    .success (data) =>
      @updateMsg = true
      @editForm = false
    .error () =>
      @location.path("/")

  deleteJob: () ->
    conf = confirm "Are you sure you want to delete this job?"
    if conf
      @http.delete("/companies/#{@job.company_id}/jobs/#{@job.id}.json")
      .success (data) =>
        @rootScope.deleteMsg = true
        @location.path("/companies/#{@job.company_id}")
      .error () =>
        @location.path("/")

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

JobsControllers.controller("JobsShowCtrl", JobsShowCtrl)
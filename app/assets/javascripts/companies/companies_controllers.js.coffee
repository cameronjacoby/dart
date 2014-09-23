CompaniesControllers = angular.module("CompaniesControllers", [])

class CompaniesShowCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/companies/#{@routeParams.id}.json")
    .success (data) =>
      @company = data
      @profile = data.profile

  editCompany: () ->
    @editForm = true
    @updateMsg = false
    i = 0
    while i < @company.jobs.length
      @company.jobs[i].updateJobMsg = false
      i += 1

  updateCompany: () ->
    @nameMsg = false
    @emailMsg = false
    @http.put("/companies/#{@company.id}.json", {company: @company})
    .success (data) =>
      if data == "NAME ERROR"
        @company.name = ""
        @nameMsg = true
      else
        @http.put("/users/#{@company.user_id}.json", {user: @company.user})
        .success (data) =>
          if data == "EMAIL ERROR"
            @company.user.email = ""
            @emailMsg = true
          else
            @editForm = false
            @updateMsg = true
    .error () =>
      @location.path("/")

  deleteCompany: () ->
    conf = confirm "Are you sure you want to delete your company profile?"
    if conf
      @http.delete("/users/#{@company.user_id}.json")
      .success (data) =>
        @location.path("/")

  showNewJobForm: () ->
    @newJobForm = true

  addJob: (newJob) ->
    @http.post("/companies/#{@company.id}/jobs.json", {job: newJob})
    .success (data) =>
      @scope.newJob = {}
      @job = data
      @location.path("/companies/#{@company.id}/jobs/#{@job.id}")
    .error () =>
      @location.path("/")

  editJob: (job) ->
    skills = []
    i = 0
    while i < job.skills.length
      skills.push job.skills[i].name
      i += 1
    job.skill_names = skills.join(", ")
    job.editJobForm = true
    job.updateJobMsg = false
    @hideWhenEditingJob = true
    @updateMsg = false

  updateJob: (job) ->
    @http.put("/companies/#{@company.id}/jobs/#{job.id}.json", {job: job})
    .success (data) =>
      job.updateJobMsg = true
      job.editJobForm = false
      @hideWhenEditingJob = false
    .error () =>
      @location.path("/")

  deleteJob: (job) ->
    conf = confirm "Are you sure you want to delete this job?"
    if conf
      @http.delete("/companies/#{@company.id}/jobs/#{job.id}.json")
      .success (data) =>
        @company.jobs.splice(@company.jobs.indexOf(job), 1)
        if @company.jobs.length == 0
          @jobsToggle = true
      .error () =>
        @location.path("/")

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

CompaniesControllers.controller("CompaniesShowCtrl", CompaniesShowCtrl)
CompaniesControllers = angular.module("CompaniesControllers", [])

class CompaniesShowCtrl
  
  constructor: (@scope, @http, @routeParams, @location) ->
    @http.get("/companies/#{@routeParams.id}.json").success (data) =>
      @company = data
      @profile = data.profile

  editCompany: () ->
    @editForm = true
    @updateMsg = false

  updateCompany: () ->
    @nameMsg = false
    @emailMsg = false
    @http.put("/companies/#{@company.id}.json", {company: @company}).success (data) =>
      if data == "NAME ERROR"
        @company.name = ""
        @nameMsg = true
      else
        @http.put("/users/#{@company.user_id}.json", {user: @company.user}).success (data) =>
          if data == "EMAIL ERROR"
            @company.user.email = ""
            @emailMsg = true
          else
            @editForm = false
            @updateMsg = true

  deleteCompany: () ->
    conf = confirm "Are you sure you want to delete your company profile?"
    if conf
      @http.delete("/users/#{@company.user_id}.json").success (data) =>
        @location.path("/")

  showNewJobForm: () ->
    @newJobForm = true

  addJob: (newJob) ->
    @http.post("/companies/#{@company.id}/jobs.json", {job: newJob}).success (data) =>
      @scope.newJob = {}
      @job = data
      @location.path("/companies/#{@company.id}/jobs/#{@job.id}")

  editJob: (job) ->
    skills = []
    i = 0
    while i < job.skills.length
      skills.push job.skills[i].name
      i += 1
    job.skill_names = skills.join(", ")
    job.updateJobMsg = false
    job.editJobForm = true
    @editJobHide = true

  updateJob: (job) ->
    @http.put("/companies/#{@company.id}/jobs/#{job.id}.json", {job: job}).success (data) =>
      console.log "UPDATED!!!"
      job.updateJobMsg = true
      job.editJobForm = false
      @editJobHide = false

  deleteJob: (job) ->
    conf = confirm "Are you sure you want to delete this job?"
    if conf
      @http.delete("/companies/#{@company.id}/jobs/#{job.id}.json").success (data) =>
        @company.jobs.splice(@company.jobs.indexOf(job), 1)
        if @company.jobs.length == 0
          @jobsToggle = true

CompaniesControllers.controller("CompaniesShowCtrl", ["$scope", "$http", "$routeParams", "$location", CompaniesShowCtrl])
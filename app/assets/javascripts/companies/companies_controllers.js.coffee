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

CompaniesControllers.controller("CompaniesShowCtrl", ["$scope", "$http", "$routeParams", "$location", CompaniesShowCtrl])
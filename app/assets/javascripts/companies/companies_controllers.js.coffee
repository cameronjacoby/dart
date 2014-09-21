CompaniesControllers = angular.module("CompaniesControllers", [])

class CompaniesShowCtrl
  
  constructor: (@scope, @http, @routeParams, @location) ->
    @http.get("/companies/#{@routeParams.id}.json").success (data) =>
        @company = data
        @profile = data.profile

  deleteCompany: () ->
    conf = confirm "Are you sure you want to delete your company profile?"
    if conf
      @http.delete("/users/#{@company.user_id}.json").success (data) =>
        @location.path("/")

CompaniesControllers.controller("CompaniesShowCtrl", ["$scope", "$http", "$routeParams", "$location", CompaniesShowCtrl])
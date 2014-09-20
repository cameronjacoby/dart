CompaniesControllers = angular.module("CompaniesControllers", [])

class CompaniesShowCtrl
  
  constructor: (@scope, @http, @routeParams) ->
    @http.get("/companies/#{@routeParams.id}.json").success (data) =>
        @company = data.company
        @profile = data.profile

CompaniesControllers.controller("CompaniesShowCtrl", ["$scope", "$http", "$routeParams", CompaniesShowCtrl])
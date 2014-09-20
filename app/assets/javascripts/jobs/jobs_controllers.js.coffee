JobsControllers = angular.module("JobsControllers", [])

class JobsCtrl
  
  constructor: (@scope, @http) ->
    @http.get("/jobs.json").success (data) =>
      @jobs = data

JobsControllers.controller("JobsCtrl", ["$scope", "$http", JobsCtrl])
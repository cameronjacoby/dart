JobsControllers = angular.module("JobsControllers", [])

class JobsCtrl
  
  constructor: (@scope, @http) ->
    @greeting = "hello world"

JobsControllers.controller("JobsCtrl", ["$scope", "$http", JobsCtrl])
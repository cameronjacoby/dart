UsersControllers = angular.module("UsersControllers", [])

class UsersNewCtrl
  
  constructor: (@scope, @http, @routeParams) ->
    @greeting = "hello world"

  createSeeker: (@user, @seeker) ->
    @user.is_seeker = true
    console.log @user

UsersControllers.controller("UsersNewCtrl", ["$scope", "$http", "$routeParams", UsersNewCtrl])
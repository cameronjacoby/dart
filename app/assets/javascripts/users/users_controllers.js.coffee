UsersControllers = angular.module("UsersControllers", [])

class UsersNewCtrl
  
  constructor: (@scope, @http, @routeParams) ->
    @greeting = "hello world"

  createSeeker: (newUser, newSeeker) ->
    newUser.is_seeker = true
    console.log "USER", newUser
    console.log "SEEKER", newSeeker
    @http.post("/users.json", {user: newUser}).success (data) ->
      @newUser = data
      console.log "NEW USER", @newUser

UsersControllers.controller("UsersNewCtrl", ["$scope", "$http", "$routeParams", UsersNewCtrl])
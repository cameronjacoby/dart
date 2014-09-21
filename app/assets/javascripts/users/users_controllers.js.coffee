UsersControllers = angular.module("UsersControllers", [])

class UsersNewCtrl
  
  constructor: (@scope, @http, @routeParams) ->
    @greeting = "hello world"

  createSeeker: (newUser, newSeeker) ->
    newUser.is_seeker = true
    console.log "USER", newUser
    console.log "SEEKER", newSeeker
    @http.post("/users.json", {user: newUser}).success (data) =>
      @emailMsg = false
      @passLenMsg = false
      @passConfMsg = false
      @errorMsg = false
      if data == "EMAIL ERROR"
        newUser.email = ""
        @emailMsg = true
      else if data == "PASSWORD LENGTH ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passLenMsg = true
      else if data == "PASSWORD CONF ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passConfMsg = true
      else if data == "ERROR"
        @scope.newUser = {}
        @scope.newSeeker = {}
        @errorMsg = true
      else
        @scope.newUser = {}
        @scope.newSeeker = {}
        @newUser = data
        console.log "NEW USER", @newUser

UsersControllers.controller("UsersNewCtrl", ["$scope", "$http", "$routeParams", UsersNewCtrl])
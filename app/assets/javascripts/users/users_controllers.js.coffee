UsersControllers = angular.module("UsersControllers", [])

class UsersNewCtrl
  
  constructor: (@scope, @http, @routeParams, @location) ->
    @greeting = "hello world"

  createSeeker: (newUser, newSeeker) ->
    newUser.is_seeker = true
    console.log "USER", newUser
    console.log "SEEKER", newSeeker
    @http.post("/users.json", {user: newUser, seeker: newSeeker}).success (data) =>
      @emailMsgSeek = false
      @passLenMsgSeek = false
      @passConfMsgSeek = false
      @errorMsgSeek = false
      if data == "EMAIL ERROR"
        newUser.email = ""
        @emailMsgSeek = true
      else if data == "PASSWORD LENGTH ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passLenMsgSeek = true
      else if data == "PASSWORD CONF ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passConfMsgSeek = true
      else if data == "ERROR"
        @scope.newUserSeek = {}
        @scope.newSeeker = {}
        @errorMsgSeek = true
      else
        @scope.newUserSeek = {}
        @scope.newSeeker = {}
        @newSeeker = data
        console.log "NEW SEEKER", @newSeeker
        @location.path("/seekers/#{@newSeeker.id}")

  createCompany: (newUser, newCompany) ->
    newUser.is_company = true
    console.log "USER", newUser
    console.log "COMPANY", newCompany
    @http.post("/users.json", {user: newUser, company: newCompany}).success (data) =>
      @emailMsgComp = false
      @passLenMsgComp = false
      @passConfMsgComp = false
      @nameMsgComp = false
      @errorMsgComp = false
      if data == "EMAIL ERROR"
        newUser.email = ""
        @emailMsgComp = true
      else if data == "PASSWORD LENGTH ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passLenMsgComp = true
      else if data == "PASSWORD CONF ERROR"
        newUser.password = ""
        newUser.password_confirmation = ""
        @passConfMsgComp = true
      else if data.error == "NAME ERROR"
        newCompany.name = ""
        @nameMsgComp = true
        @http.delete("/users/#{data.user.id}.json").success (data) ->
      else if data.error == "ERROR"
        @scope.newUserComp = {}
        @scope.newCompany = {}
        @errorMsgComp = true
        @http.delete("/users/#{data.user.id}.json").success (data) ->
      else if data == "ERROR"
        @scope.newUserComp = {}
        @scope.newCompany = {}
        @errorMsgComp = true
      else
        @scope.newUserComp = {}
        @scope.newCompany = {}
        @newCompany = data
        console.log "NEW COMPANY", @newCompany
        @location.path("/companies/#{@newCompany.id}")

UsersControllers.controller("UsersNewCtrl", ["$scope", "$http", "$routeParams", "$location", UsersNewCtrl])
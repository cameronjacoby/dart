UsersControllers = angular.module("UsersControllers", [])

class UsersNewCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)

  createSeeker: (newUser, newSeeker) ->
    newUser.is_seeker = true
    console.log "USER", newUser
    console.log "SEEKER", newSeeker
    @emailMsgSeek = false
    @passLenMsgSeek = false
    @passConfMsgSeek = false
    @errorMsgSeek = false

    @http.post("/users.json", {user: newUser, seeker: newSeeker})
    .success (data) =>
      @scope.newUserSeek = {}
      @scope.newSeeker = {}
      @newSeeker = data
      console.log "NEW SEEKER", @newSeeker

      @http.post("/login.json", {user: newUser})
      .success (data) =>
        console.log "SIGNED IN SUCCESSFULLY"
        @set_user data
        console.log "CURRENT USER", @rootScope.currentUser
        @location.path("/seekers/#{@newSeeker.id}")

    .error (data) =>
      console.log data
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
        @location.path("/")


  createCompany: (newUser, newCompany) ->
    newUser.is_company = true
    console.log "USER", newUser
    console.log "COMPANY", newCompany
    @emailMsgComp = false
    @passLenMsgComp = false
    @passConfMsgComp = false
    @nameMsgComp = false
    @errorMsgComp = false

    @http.post("/users.json", {user: newUser, company: newCompany})
    .success (data) =>
      @scope.newUserComp = {}
      @scope.newCompany = {}
      @newCompany = data
      console.log "NEW COMPANY", @newCompany

      @http.post("/login.json", {user: newUser})
      .success (data) =>
        console.log "SIGNED IN SUCCESSFULLY"
        @set_user data
        console.log "CURRENT USER", @rootScope.currentUser
        @location.path("/companies/#{@newCompany.id}")

    .error (data) =>
      console.log data
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
      else if data == "ERROR"
        @scope.newUserComp = {}
        @scope.newCompany = {}
        @errorMsgComp = true
      else if data.error == "COMPANY NAME ERROR"
        newCompany.name = ""
        @nameMsgComp = true
        @http.delete("/users/#{data.user_id}.json")
        .success (data) ->
      else if data.error == "COMPANY ERROR"
        @scope.newUserComp = {}
        @scope.newCompany = {}
        @errorMsgComp = true
        @http.delete("/users/#{data.user_id}.json")
        .success (data) ->
      else
        @location.path("/")


  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

UsersControllers.controller("UsersNewCtrl", UsersNewCtrl)
SessionControllers = angular.module("SessionControllers", [])

class SessionCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope, @location) ->
    super(@http, @rootScope, @location)

  createSession: (user) ->
    @rootScope.logoutMsg = false
    @emailMsg = false
    @passwordMsg = false
    @errorMsg = false
    console.log "SIGNING IN", user

    @http.post("/login.json", {user: user})
    .success (data) =>
      user.email = ""
      user.password = ""
      console.log "SIGNED IN SUCCESSFULLY"
      @set_user data
      console.log "CURRENT USER", @rootScope.currentUser
      if @rootScope.currentUser.is_seeker
        @location.path("/seekers/#{@rootScope.currentUser.seeker.id}")
      else if @rootScope.currentUser.is_company
        @location.path("/companies/#{@rootScope.currentUser.company.id}")

    .error (data) =>
      console.log data
      if data == "EMAIL NOT FOUND"
        user.email = ""
        user.password = ""
        @emailMsg = true
      else if data == "INVALID PASSWORD"
        user.password = ""
        @passwordMsg = true
      else if data == "ERROR"
        @errorMsg = true

  @$inject = ["$scope", "$http", "$rootScope", "$location"]

SessionControllers.controller("SessionCtrl", SessionCtrl)
SessionControllers = angular.module("SessionControllers", [])

class SessionCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope, @location) ->
    if @rootScope.currentUser
      @location.path("/")
    super(@http, @rootScope, @location)

  createSession: (user) ->
    console.log "SIGNING IN", user
    @http.post("/login.json", {user: user}).success (data) =>
      @set_user data
      console.log @rootScope.currentUser
      if @rootScope.currentUser.is_seeker
        @location.path("/seekers/#{@rootScope.currentUser.seeker.id}")
      else if @rootScope.currentUser.is_company
        @location.path("/companies/#{@rootScope.currentUser.company.id}")

  @$inject = ["$scope", "$http", "$rootScope", "$location"]

SessionControllers.controller("SessionCtrl", SessionCtrl)
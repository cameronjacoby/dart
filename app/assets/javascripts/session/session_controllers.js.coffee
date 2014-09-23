SessionControllers = angular.module("SessionControllers", [])

class SessionCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope, @location) ->
    if @signed_in
      @location.path("/")
    super(@http, @rootScope, @location)

  createSession: (user) ->
    console.log user
    console.log "CREATE SESSION"
    @sign_in user, () =>
      if @rootScope.currentUser.is_seeker
        @location.path("/seekers/#{@rootScope.currentUser.seeker.id}")
      else if @rootScope.currentUser.is_company
        @location.path("/companies/#{@rootScope.currentUser.company.id}")

  @$inject = ["$scope", "$http", "$rootScope", "$location"]

SessionControllers.controller("SessionCtrl", SessionCtrl)
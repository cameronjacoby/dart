SessionControllers = angular.module("SessionControllers", [])

class SessionCtrl extends MainCtrl
  
  constructor: (@scope, @http, @rootScope) ->
    @greeting = "hello world"
    super(@http, @rootScope)

  createSession: (user) ->
    console.log user
    console.log "SESSION STARTING!!!"
    @sign_in user

  @$inject = ["$scope", "$http", "$rootScope"]

SessionControllers.controller("SessionCtrl", SessionCtrl)
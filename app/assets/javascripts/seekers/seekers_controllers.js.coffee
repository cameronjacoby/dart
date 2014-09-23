SeekersControllers = angular.module("SeekersControllers", [])

class SeekersShowCtrl extends MainCtrl
  
  constructor: (@scope, @http, @routeParams, @rootScope, @location) ->
    super(@http, @rootScope, @location)
    @http.get("/seekers/#{@routeParams.id}.json")
    .success (data) =>
      @seeker = data
    .error () =>
      if @rootScope.currentUser.is_seeker
        @location.path("/seekers/#{@rootScope.currentUser.seeker.id}")
      else if @rootScope.currentUser.is_company
        @location.path("/companies/#{@rootScope.currentUser.company.id}")

  editSeeker: () ->
    @editForm = true
    @updateMsg = false

  updateSeeker: () ->
    @emailMsg = false
    @http.put("/seekers/#{@seeker.id}.json", {seeker: @seeker})
    .success (data) =>
      @http.put("/users/#{@seeker.user_id}.json", {user: @seeker.user})
      .success (data) =>
        if data == "EMAIL ERROR"
          @seeker.user.email = ""
          @emailMsg = true
        else
          @editForm = false
          @updateMsg = true
    .error () =>
      @location.path("/")

  deleteSeeker: () ->
    conf = confirm "Are you sure you want to delete your profile?"
    if conf
      @http.delete("/users/#{@seeker.user_id}.json")
      .success (data) =>
        @location.path("/")

  @$inject = ["$scope", "$http", "$routeParams", "$rootScope", "$location"]

SeekersControllers.controller("SeekersShowCtrl", SeekersShowCtrl)
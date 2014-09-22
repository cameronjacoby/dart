SeekersControllers = angular.module("SeekersControllers", [])

class SeekersShowCtrl
  
  constructor: (@scope, @http, @routeParams, @location) ->
    @http.get("/seekers/#{@routeParams.id}.json").success (data) =>
      @seeker = data

  editSeeker: () ->
    @editForm = true
    @updateMsg = false

  updateSeeker: () ->
    @emailMsg = false
    @http.put("/seekers/#{@seeker.id}.json", {seeker: @seeker}).success (data) =>
      @http.put("/users/#{@seeker.user_id}.json", {user: @seeker.user}).success (data) =>
        if data == "EMAIL ERROR"
          @seeker.user.email = ""
          @emailMsg = true
        else
          @editForm = false
          @updateMsg = true

  deleteSeeker: () ->
    conf = confirm "Are you sure you want to delete your profile?"
    if conf
      @http.delete("/users/#{@seeker.user_id}.json").success (data) =>
        @location.path("/")

SeekersControllers.controller("SeekersShowCtrl", ["$scope", "$http", "$routeParams", "$location", SeekersShowCtrl])
angular.module("DartApp", [
  "UsersRouter",
  "UsersControllers",
  "SeekersRouter",
  "SeekersControllers",
  "CompaniesRouter",
  "CompaniesControllers",
  "JobsRouter",
  "JobsControllers",
  "SkillsRouter",
  "SkillsControllers",
  "SessionRouter",
  "SessionControllers"
])

class MainCtrl

  constructor: (@http, @rootScope) ->
    console.log "CHECKING SESSION", @signed_in()
    console.log "CURRENT USER", @currentUser
    @rootScope.signed_in = @signed_in

    @rootScope.sign_out = () =>
      @http.delete("/logout.json")
      .success (data) =>
        console.log "DATA", data
        @set_user null
        @location.path("/login")

    if !@signed_in()
      @http.get("/users/current_user.json")
      .success (data) =>
        console.log "USER DATA", data
        if data != "null"
          @set_user data
          console.log "CURRENT USER", @currentUser
          if @location.url() == "/login" || @location.url() == "/register"
            @location.path("/")
        else
          @http.delete("/logout.json").success () =>
            @set_user null
    return this
      
  signed_in: () ->
    !!@currentUser

  set_user: (user) ->
    @rootScope.currentUser = @currentUser = user

window.MainCtrl = MainCtrl
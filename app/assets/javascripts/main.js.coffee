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
  "SessionControllers",
  "SessionProviders"
])

class MainCtrl 

  constructor: (@http, @rootScope) ->
    console.log "CHECKING SESSION", @signed_in()
    console.log @currentUser
    @rootScope.signed_in = @signed_in

    @rootScope.sign_out = () =>
      # destroy session
      @http.get("/logout.json")
      .success () =>
        # set current user to null
        @set_user null
        # 'redirect' to homepage

    if !@signed_in()
      @http.get("/users/current_user.json")
      .success (data) =>
        console.log("USER DATA", data)
        if data != "null"
          # set user to current user
          @set_user data
        else
          # make sure session is destroyed (since no current user)
          @rootScope.sign_out()
    return this
      
  signed_in: () ->
    !!@currentUser

  set_user: (user) ->
    @rootScope.currentUser = @currentUser = user

  sign_in: (user, success, fail)->
    console.log "SIGNING IN", user
    @http.post("/login.json", {user: user})
    .success (user) =>
      @set_user user
      # callback function on success
      success()
    .error
      # callback function on fail

window.MainCtrl = MainCtrl
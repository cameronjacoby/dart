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

  constructor: (@http, @rootScope)->
    console.log "Checking Session", @signed_in()
    console.log @currentUser
    @rootScope.signed_in = @signed_in
    @rootScope.sign_out = ()=>
      @http.get("/logout.json")
      .success ()=>
        @set_user null
    if !@signed_in()
      @http.get("/users/current_user.json")
      .success (userData) =>
        console.log("userData", userData)
        console.dir userData
        if userData != "null"
          @set_user userData
        else
          console.log "what??"
          @rootScope.sign_out()
    return this
      
  signed_in: ()->
    !!@currentUser

  set_user: (user)->
    @rootScope.currentUser = @currentUser = user

  sign_in: (user, success, fail)->
    console.log "Signing In", user
    @http.post("/login.json", {user: user})
    .success (user) =>
      @set_user user
      success()
    .error fail


# angular.module("MainCtrl", MainCtrl)
window.MainCtrl = MainCtrl
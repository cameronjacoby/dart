# SessionProviders = angular.module("SessionProviders", [])

# class Session 

#   constructor: (@http, @rootScope) ->
#     console.log "Checking Session"
#     @current_user = null
#     @http.get("/users/current_user")
#     .success (userData) =>
#       @sign_in userData if userData != {}

#   signed_in: () ->
#     !!@currentUser

#   sign_in: (user) ->
#     @rootScope.currentUser = @currentUser = user


# SessionProviders.service("Session", ["$http", "$rootScope", Session])
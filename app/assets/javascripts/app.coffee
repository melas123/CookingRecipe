# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@cooking = angular.module( 'cookingRecipes',[ 'Devise', 'ngRoute', 'templates', 'ui.bootstrap','ui.select','toaster','ngAnimate', 'angularFileUpload' ] )
  .controller('mainCtrl', ($scope, Auth, datacontext) ->
    # get current user
    Auth.currentUser().then  (user) ->
      $scope.user = user

  )
  #this Factory is here beacause I am in the process of testing the profile factory in Jasmine
  .factory 'Profile', ( $http, Notification ) ->

    # get user by id
    @getUser = (id) ->
      $http.get( '/profile/find_user/'+id+'.json').success((data ) ->
        return data
      )
    return @
  .service 'Notification', (toaster) ->

    @error = ( msg ) ->
      toaster.pop 'error', 'Error', msg

    @success = ( msg ) ->
      toaster.pop 'success', 'success', msg

    @info = ( msg ) ->
      toaster.pop 'info', 'Validation', msg

    @warning = ( msg ) ->
      toaster.pop 'warning', 'Validation', msg
    return

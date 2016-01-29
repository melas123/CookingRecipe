# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

@cooking = angular.module(
'cookingRecipes',[ 'Devise', 'ngRoute', 'templates',
            'ui.bootstrap','ui.select','toaster','ngAnimate', 'angularFileUpload' ] )
  .controller('mainCtrl', ($scope, Auth, datacontext) ->
    # get current user
    Auth.currentUser().then  (user) ->
      $scope.user = user

  )

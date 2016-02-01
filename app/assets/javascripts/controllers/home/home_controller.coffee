@cooking.controller 'homeCtrl', ($scope, datacontext, GetModal, Notification, $rootScope, Auth) ->


  $scope.isAuthenticated = Auth.isAuthenticated()

  datacontext.getRecipes().success( (data) ->
    $rootScope.recipes = data.recipes
  ).error ( data ) ->
    alert 'Error on getting recipes'

  #check if user is connected or not
  $scope.isAuthenticated = Auth.isAuthenticated()

  $scope.openModalCreateRecipe = ->
    GetModal.create_recipe()


  $scope.openModalEditRecipe = ( recipe ) ->
    GetModal.edit_recipe( recipe )


  $rootScope.$on 'ReloadRecipe', (event, data) ->
    datacontext.getRecipes().success (data) ->
<<<<<<< HEAD
      $rootScope.recipes = data.recipes
=======
      $rootScope.recipes = data.recipes
>>>>>>> FIX Authentification user because see users followers

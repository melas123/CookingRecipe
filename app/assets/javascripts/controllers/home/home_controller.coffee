@cooking.controller 'homeCtrl', ($scope, datacontext, GetModal, Notification, $rootScope, Auth) ->

  $scope.isAuthenticated = Auth.isAuthenticated()

  datacontext.getRecipes().success( (data) ->
    $rootScope.recipes = data.recipes
  ).error (data, status) ->
    alert 'Error on getting recipes'


  $scope.openModalRecipe = ( item ) ->
    GetModal.recipe( item )


  $rootScope.$on 'ReloadRecipe', (event, data) ->
    datacontext.getRecipes().success (data) ->
      $rootScope.recipes = data.recipes


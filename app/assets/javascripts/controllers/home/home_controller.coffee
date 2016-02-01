@cooking.controller 'homeCtrl', ($scope, datacontext, GetModal, Notification, $rootScope, Auth) ->

  $scope.isAuthenticated = Auth.isAuthenticated() 

  datacontext.getRecipes().success( (data) ->
    $rootScope.recipes = data.recipes
  ).error ( data ) ->
    alert 'Error on getting recipes'


  $scope.openModalCreateRecipe = ->
    GetModal.create_recipe()


  $scope.openModalEditRecipe = ( recipe ) ->
    GetModal.edit_recipe( recipe )


  $rootScope.$on 'ReloadRecipe', (event, data) ->
    datacontext.getRecipes().success (data) ->
      $rootScope.recipes = data.recipes
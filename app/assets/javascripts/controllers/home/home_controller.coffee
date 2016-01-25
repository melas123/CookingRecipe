@cooking.controller 'homeCtrl', ( $scope, datacontext, GetModal, Notification, $rootScope, Auth ) ->
  $scope.page = 1

  $scope.isAuthenticated = Auth.isAuthenticated()

   # Create a watcher to watch user input
  $scope.$watch 'searchQuery', _.debounce( ( ( newValue, oldValue ) ->
    if ( newValue != oldValue )
      $scope.searchQuery = newValue
   # update view after 600ms when changes is detected
    $scope.$apply ->
      $scope.searchRecipe( $scope.searchQuery, $scope.page )
      return
    return
   ), 600 )

  datacontext.getRecipes().success( ( data ) ->
    $rootScope.recipes = data.recipes
    ).error ( data, status ) ->
    alert 'Error on getting recipes'

  $scope.searchRecipe = ( search, page )->
    searchObject=
      search: search
      page:   page
    datacontext.searchRecipes( searchObject ).success( ( data ) ->
      $scope.recipes       =   data.recipes
      $scope.fromIndex     =   data.from_index
      $scope.toIndex       =   data.to_index
      $scope.totalEntries  =   data.total_entries
      $scope.currentPage   =   data.current_page
      ).error ( data, status ) ->
        alert 'Error on getting recipes'

  $rootScope.$on 'ReloadRecipe', ( event, data ) ->
    datacontext.getRecipes().success ( data ) ->
      $rootScope.recipes = data.recipes

  $scope.openModalCreateRecipe = ->
    GetModal.create_recipe()

  $scope.openModalEditRecipe = ( recipe ) ->
    GetModal.edit_recipe( recipe )

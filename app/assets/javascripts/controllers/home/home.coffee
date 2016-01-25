@cooking.controller 'homeCtrl', ($scope,$location,restService) ->
  $scope.page=1
  #search for recipe
  $scope.searchRecipe = ->
    #console.log($scope.search)
    #console.log($scope.page)
    $scope.recipes = restService.perpage.search(
      search: $scope.search
      page: $scope.page
    ).$promise.then((data) ->
      $scope.results = data.recipes
      $scope.from_index = data.from_index
      $scope.to_index = data.to_index
      $scope.total_entries = data.total_entries
      $scope.current_page = data.current_page
      console.log(data)
    )

  $scope.getRecipes = (page)  ->
    restService.perpage.query(page: page).$promise.then((data) ->
      $scope.results = data.recipes
      $scope.from_index = data.from_index
      $scope.to_index = data.to_index
      $scope.total_entries = data.total_entries
      $scope.current_page = data.current_page
      console.log(data)
    )

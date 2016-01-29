@cooking.controller 'showCtrl', ($scope, $routeParams,Auth, datacontext, Recipe, Favorite) ->

  #initialize variables
  $scope.id = $routeParams.id;
  $scope.recipe = {}
  $scope.ingridients = [{id:1,name:"huile"},{id:1,name:"oeuf"}]

  # get recipe by id
  Recipe.getRecipe($scope.id).success (data) ->
    $scope.recipe = data

  # check that recipe is a favorite or not
  Favorite.isFavorite($scope.id).success (data) ->
    $scope.isFavorite = data

  # create or delete a favorite
  $scope.createOrDelete = ->
    if $scope.isFavorite
      $scope.destroyFavorite()
    else
      $scope.createFavorite()
  # create a favorite
  $scope.createFavorite = ->
    Favorite.createFavorite(recipe_id : $scope.id).success (data) ->
      $scope.isFavorite = true
  # destroy a favorite
  $scope.destroyFavorite = ->
    Favorite.destroyFavorite(recipe_id : $scope.id).success (data) ->
      $scope.isFavorite = false

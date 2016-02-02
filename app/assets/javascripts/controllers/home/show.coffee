@cooking.controller 'showCtrl', ($scope, $routeParams,Auth, datacontext, Recipe, Favorite, Profile, $log) ->

  #initialize variables
  $scope.id = $routeParams.id      #recipe_id in params
  $scope.recipe = {}
  $scope.ingridients = []
  $scope.comments = []

  #check if user is connected or not
  $scope.isAuthenticated = Auth.isAuthenticated()

  # get recipe by id
  Recipe.getRecipe($scope.id).success (data) ->
    $scope.recipe = data
    $scope.ingridients  = $scope.recipe.ingredients

  # get comments by recipe id
  Recipe.getCommentsByRecipeId($scope.id).success (data) ->
    $scope.comments = data

  $scope.getUserName = (id) ->
    Profile.getUser(id).success((data) ->
      console.log(data)
      return data.name
      )

  if $scope.isAuthenticated
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

  # create a comment
  $scope.addComment = (new_comment) ->
    Recipe.createComment(recipe_id : $scope.id, text : new_comment).success (data) ->
      $scope.comments.unshift({ text: data.text, name: $scope.user.name })
      $scope.new_comment = ''

  # destroy a favorite
  $scope.destroyFavorite = ->
    Favorite.destroyFavorite(recipe_id : $scope.id).success (data) ->
      $scope.isFavorite = false

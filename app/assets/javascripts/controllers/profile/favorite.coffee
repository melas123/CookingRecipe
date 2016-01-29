@cooking.controller 'favoriteCtrl', ($scope, Auth, Favorite) ->

  # get list favorites recipes for current user
  Favorite.getFavoritesRecipes().success (data) ->
    $scope.favorites = data

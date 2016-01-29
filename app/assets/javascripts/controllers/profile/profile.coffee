@cooking.controller 'profileCtrl', ($scope, Auth, datacontext, $routeParams, Profile ) ->

  #initialize variables
  $scope.id = $routeParams.id

  #get all recipes
  datacontext.getRecipes().success( (data) ->
    $scope.recipes = data.recipes
  )

  #get user by id
  Profile.getUser($scope.id).success( (data) ->
    $scope.user_profile = data[0]
  )

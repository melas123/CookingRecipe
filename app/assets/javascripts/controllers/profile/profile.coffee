@cooking.controller 'profileCtrl', ($scope, Auth, datacontext, $routeParams, Profile, $route ) ->

  #initialize variables
  $scope.id = $routeParams.id    #user_id in params

  # get number followers for current user
  Profile.getNbFollowers($scope.id).success (data) ->
    $scope.nbFollowers = data

  # check that user is followed by current user or not
  Profile.isFollowed($scope.id).success (data) ->
    $scope.isFollowed = data

  # get number following for current user
  Profile.getNbFollowing($scope.id).success (data) ->
    $scope.nbFollowing = data

  # create new follow for user
  $scope.createFollow = ->
    Profile.createFollow(followed_id : $scope.id).success( (data) ->
      $scope.isFollowed = true
    )
  # remove a follow
  $scope.removeFollow = () ->
    Profile.removeFollow(followed_id : $scope.id).success( (data) ->
      $scope.isFollowed = false
    )
  #get user by id
  Profile.getUser($scope.id).success( (data) ->
    $scope.user_profile = data[0]
  )

  # get recipes by user id
  Profile.getRecipesByUserId($scope.id).success( (data) ->
    $scope.recipes = data
  )

  # create new follow for user
  $scope.createFollow = ->
    Profile.createFollow(followed_id : $scope.id).success( (data) ->
    )

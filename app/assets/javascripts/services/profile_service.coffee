@cooking.factory 'Profile', ( $http, Notification ) ->

  # get user by id
  @getUser = (id) ->
    $http.get( '/profile/find_user/'+id+'.json').success((data ) ->
      return data
    )

  # get recipes by user id
  @getRecipesByUserId = (id) ->
    $http.get( '/profile/recipes_user/'+id+'.json').success((data ) ->
      return data
    )

  # check that user is followed by current user or not
  @isFollowed = (id) ->
    $http.get( '/relationship/isFollowed/'+id+'.json').success((data ) ->
      return data
    )

  # get following users by user id
  @getNbFollowingByUserId = (id) ->
    $http.get( '/relationship/following/'+id+'.json').success((data ) ->
      return data
    )

  # get followers users by user id
  @getNbFollowersByUserId = (id) ->
    $http.get( '/relationship/followers/'+id+'.json').success((data ) ->
      return data
    )

  # create new follow
  @createFollow = (id) ->
    $http.post( '/relationship/follow.json',id).success((data ) ->
      Notification.success( "Cet utilisateur est désormais dans vos utilisateurs suivis" )
      return data
    )

  # remove a follow
  @removeFollow = (id) ->
    $http.post( '/relationship/unfollow.json',id).success((data ) ->
      return data
    )

  # get number followers for current user
  @getNbFollowers = (id) ->
    $http.get( '/relationship/nbrFollowers/'+id+'.json').success((data ) ->
      return data
    )

  # get number followers for current user
  @getNbFollowing = (id) ->
    $http.get( '/relationship/nbrFollowing/'+id+'.json').success((data ) ->
      return data
    )

  return @

@cooking.factory 'Profile', ( $http ) ->

  # get user by id
  @getUser = (id) ->
    $http.get( '/profile/find_user/'+id+'.json').success((data ) ->
      return data
    )
  return @

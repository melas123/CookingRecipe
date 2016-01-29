@cooking.factory 'Recipe', ( $http ) ->

  # get recipe by id
  @getRecipe = (id) ->
    $http.get( '/recipe/'+id+'.json').success((data ) ->
      return data
    )
  return @

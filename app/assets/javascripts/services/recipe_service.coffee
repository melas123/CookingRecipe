@cooking.factory 'Recipe', ( $http ) ->

  # get recipe by id
  @getRecipe = (id) ->
    $http.get( '/recipe/'+id+'.json').success(( data ) ->
      return data
    )

  # get comments by recipe id
  @getCommentsByRecipeId = (id) ->
    $http.get( '/recipe/'+id+'/comments.json').success(( data ) ->
      return data
    )

  # create a comment
  @createComment = (comment) ->
    $http.post('/recipe/'+comment.recipe_id+'/comments.json',comment).success(( data ) ->
      return data
    ).error ( data ) ->
      return data
  return @

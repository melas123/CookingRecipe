@cooking.factory 'datacontext', ( $http, Notification ) ->

  @getRecipes = ->
    $http.get( '/recipe.json' ).success ( data ) ->
      return data

  @searchRecipes = ( searchObject ) ->
    $http.get( '/recipe.json', {
      params: {
        page:   searchObject.page
        search: searchObject.search
      }
      } ).success ( data ) ->
      return data

  @getIngredients = ->
    $http.get( '/ingredient.json' ).success ( data ) ->
      return data

  @createIngredient = ( ingredient ) ->
    $http.post( '/ingredient.json', ingredient ).success(( data ) ->
      Notification.success( 'Adding ' + ingredient.name + ' successfully' )
      return data
    ).error ( data ) ->
      Notification.error( 'Error on Adding ' + ingredient.name )

  @createRecipe = ( recipe, ingredientRecipes ) ->
    $http.post( '/recipe.json', recipe ).success( ( data ) ->
      for ingredRecipe, i in ingredientRecipes
        ingredRecipe.recipe_id = data.id
      $http.post( '/ingredient_recipe.json', ingredientRecipes ).success( ( data) ->
        return data
      ).error ( data ) ->
        Notification.success( 'Adding ' + recipe.title + ' successfully' )
    ).error ( data ) ->
      Notification.error( 'Error on Adding ' + recipe.title )

  @updateRecipe = ( recipe, listRecipeIngredient ) ->
    $http.put( '/recipe/' + recipe.id + '.json', recipe ).success(( data ) ->
      $http.post( '/ingredient_recipe.json', listRecipeIngredient ).success(( data ) ->
        return data
      ).error ( data ) ->
      Notification.success( 'Updating ' + recipe.title + ' successfully' )
    ).error ( data ) ->
      Notification.error( 'Error on updating ' + recipe.title )

  @destroyIngredientRecipe = ( id ) ->
    $http.delete( '/ingredient_recipe/'+ id + '.json', id).success( ( data ) ->
      return data
    ).error ( data ) ->
      Notification.error( 'Error On deleting ingredient recipe' )
  return @

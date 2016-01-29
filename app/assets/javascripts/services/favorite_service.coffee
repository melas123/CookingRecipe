@cooking.factory 'Favorite', ( $http, Notification ) ->

  #create new favorite
  @createFavorite = ( recipe_id ) ->
    $http.post( 'profile/create_favorite.json', recipe_id ).success(( data ) ->
      console.log(recipe_id)
      Notification.success( "Cette recette est désormais dans vos recettes préférées" )
    )

  #delete a favorite
  @destroyFavorite = ( recipe_id ) ->
    $http.post( 'profile/destroy_favorite.json', recipe_id ).success(( data ) ->
      Notification.success( "Cette recette a été supprimée" )
    )
  # check that the recipe is favorite or not
  @isFavorite = ( recipe_id ) ->
    $http.get( 'profile/isFavorite/'+recipe_id+'.json').success(( data ) ->
      return data
    )

  # get list favorites recipes by current user
  @getFavoritesRecipes = ->
    $http.get( 'profile/favorite_list.json' ).success ( data ) ->
      return data
  return @

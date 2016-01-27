@cooking.factory 'datacontext', ($http, toaster) ->
  
  #datacontext service body
  service =
    {
    }
    
  service.getRecipes = ->
    $http.get('/recipe.json').success (data) ->
      return data
  
  service.getIngredients = ->
    $http.get('/ingredient.json').success (data) ->
   
  service.createIngredient = (ingredient) ->
    $http.post('/ingredient.json', ingredient).success((data) ->
      toaster.pop 'success', 'Success', 'Adding ' + ingredient.name + ' successfully'
    ).error (data) ->
      toaster.pop 'error', 'Error', 'Error on Adding ' + ingredient.name
      
  service.createRecipe = (recipe, listRecipeIngredient) ->
    $http.post('/recipe.json', recipe).success((data) ->
      for ingredRecipe, i in listRecipeIngredient
        ingredRecipe.recipe_id = data.id
      $http.post('/ingredient_recipe.json', listRecipeIngredient).success((data) ->
        return data
      ).error (data) ->
        toaster.pop 'error', 'Error', 'Error on Adding Recipe Ingredients'
      toaster.pop 'success', 'Success', 'Adding ' + recipe.title + ' successfully'
    ).error (data) ->
      toaster.pop 'error', 'Error', 'Error on Adding ' + recipe.title      
	       
  service
   
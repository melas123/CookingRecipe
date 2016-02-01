@cooking.controller 'ModalEditRecipeController', ( $scope, $rootScope, $modalInstance, datacontext, Notification, recipe, volumes, weights, measures ) ->

  $scope.name =                 ''
  $scope.selectedIngredient =   []
  $scope.listRecipeIngredient = []
  $scope.ingredients =          []
  listRecipeIngredientTosend =  []


  $scope.volumes =              volumes
  $scope.weights =              weights
  $scope.measures =             measures
  $scope.chosenMeasure =        $scope.weights
  $scope.measure =              $scope.measures[0].id
  $scope.unit =                 $scope.weights[0].id
  
  
  $scope.modalTitle = 'Editer une recette'

  for item, index in recipe.ingredient_recipes
    ingredient = recipe.ingredients.filter(( (x) ->
      x.id == item.ingredient_id
    ))[0]
    obj =
      ingredient :           ingredient
      ingredient_id :        ingredient.id
      recipe_id :            item.recipe_id
      ingredient_recipe_id : item.id
      quantity :             item.quantity
      mass_unit :            item.mass_unit
      volume_unit :          item.volume_unit
      measure :              item.measure
    $scope.listRecipeIngredient.push( obj )

  $scope.recipe =
    title:        recipe.title
    description:  recipe.description


  datacontext.getIngredients().success( (data) ->
    $scope.ingredients = data
  ).error ( data, status ) ->
    alert 'Error on getting ingredients'


  $scope.changeMeasure = ->
    if $scope.measure == 1
      $scope.chosenMeasure =   $scope.weights
      $scope.unit =            $scope.weights[0].id
    if $scope.measure == 2
      $scope.chosenMeasure =   $scope.volumes
      $scope.unit =            $scope.volumes[0].id



  $scope.addTolistIngredient = ( ingred, quantity, measure,unit ) ->
    if quantity == "" or quantity == undefined  or ingred == undefined
      Notification.info( 'Please enter all informations' )
    else
      if quantity == 0
        Notification.warning( 'Quantity should be greater than 0!' )
      else
        existingIngredient = $scope.listRecipeIngredient.filter(( (x) ->
          x.ingredient.name == ingred.name
        ))
        if existingIngredient.length > 0
          Notification.warning( 'Already '+ingred.name+' exists!' )
        else
          if measure == 1
            obj =
              ingredient :      ingred
              ingredient_id :   ingred.id
              recipe_id :       recipe.id
              quantity :        quantity
              mass_unit :       unit
              volume_unit :     null
              measure :         measure
          else
            if measure == 2
              obj =
                ingredient :    ingred
                ingredient_id : ingred.id
                recipe_id :     recipe.id
                quantity :      quantity
                mass_unit :     null
                volume_unit :   unit
                measure :       measure
            else
              obj =
                ingredient :    ingred
                ingredient_id : ingred.id
                recipe_id :     recipe.id
                quantity :      quantity
                mass_unit :     null
                volume_unit :   null
                measure :       measure

          $scope.listRecipeIngredient.push(obj)
          listRecipeIngredientTosend.push(obj)  



  $scope.addIngredient = ->
    if $scope.name == '' or $scope.name == undefined
      Notification.info( 'You need to enter ingredient name!' )
    else
      sameIngredientName = $scope.ingredients.filter(( (x) ->
        x.name == $scope.name
      ))
      if sameIngredientName.length > 0
        Notification.warning( 'Already ingredient with this same name exist!' )
      else
        datacontext.createIngredient(name: $scope.name ).success (data) ->
          $scope.ingredients.push( data )
          $scope.name = ""

  #Update Recipe
  $scope.addRecipe = ->
    if !$scope.recipe.title or $scope.recipe.title == '' or !$scope.recipe.description or $scope.recipe.description == ''
      Notification.info( 'You need to enter required information!' )
    else
      datacontext.updateRecipe
        id: recipe.id
        title: $scope.recipe.title
        description: $scope.recipe.description,
        listRecipeIngredientTosend
      $rootScope.$broadcast 'ReloadRecipe', 'Some data'
      $scope.cancel()

      


  $scope.deleteIngredientFromList = ( obj ) ->
    datacontext.destroyIngredientRecipe( obj.ingredient_recipe_id )
    index = $scope.listRecipeIngredient.indexOf( obj )
    $scope.listRecipeIngredient.splice( index, 1 )
    $rootScope.$broadcast 'ReloadRecipe', 'Some data'


  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'

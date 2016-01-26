@cooking.controller 'ModalRecipeController', ($scope, $rootScope, $modalInstance,
 datacontext, Notification, recipe, FileUploader ) ->


  $scope.name                   = ''
  $scope.multiselect            = {}
  $scope.multiselect.ingredient = []
  $scope.listRecipeIngredient   = []
  $scope.ingredients            = []


  $scope.volumes = [
    { id: 1, name: 'ml'   },
    { id: 2, name: 'cl'   },
    { id: 3, name: 'litre'}
  ]
  $scope.weights = [
    { id: 1, name: 'g'     },
    { id: 2, name: 'Kg'    }
  ]
  $scope.measures = [
    { id: 1, name: 'Mass'   },
    { id: 2, name: 'Volume' },
    { id: 3, name: 'None'   }
  ]

  #upload Image

  csrf_token =         document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  uploader   =         $scope.uploader = new FileUploader(
    url:               '/image',
    alias:             'avatar',
    headers:           { 'X-CSRF-TOKEN': csrf_token,'request': 'application/json' },
    withCredentials:   true )


  $scope.chosenMeasure = $scope.weights
  $scope.measure =       $scope.measures[0].id
  $scope.unit =          $scope.weights[0].id

  if recipe
    $scope.modalTitle = 'Editer une recette'
    for item, index in recipe.ingredient_recipes
      ingredient = recipe.ingredients.filter(( (x) ->
        x.id == item.ingredient_id
      ))[0]
      obj =
        ingredient : ingredient
        quantity   : item.quantity
        unit       : item.mass_unit || item.volume_unit
        measure    : item.measure
      $scope.listRecipeIngredient.push(obj)
    $scope.recipe =
      title:        recipe.title
      description:  recipe.description
   else
    $scope.modalTitle  = 'Ajouter une recette'
    $scope.recipe =
      title:        ""
      description:  ""

  datacontext.getIngredients().success( (data) ->
    $scope.ingredients = data
  ).error (data, status) ->
    alert 'Error on getting ingredients'


  $scope.$on 'ReloadIngredient', (event, data) ->
    datacontext.getIngredients().success (data) ->
      $scope.ingredients = data


  $scope.changeMeasure = ->
    if $scope.measure == 1
      $scope.chosenMeasure =   $scope.weights
      $scope.unit =            $scope.weights[0].id
    if $scope.measure == 2
      $scope.chosenMeasure =   $scope.volumes
      $scope.unit =            $scope.volumes[0].id




  # FILTERS for the images
  uploader.filters.push
    name: 'imageFilter'
    fn: (item, options) ->
      type = '|' + item.type.slice(item.type.lastIndexOf('/') + 1) + '|'
      '|jpg|png|jpeg|bmp|gif|'.indexOf(type) != -1


  $scope.addTolistIngredient = (ingred, quantity, measure,unit) ->
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
          obj =
            ingredient : ingred
            quantity   : quantity
            unit       : unit
            measure    : measure
          $scope.listRecipeIngredient.push(obj)


  $scope.deleteIngredientFromList = (obj) ->
    index = $scope.listRecipeIngredient.indexOf(obj)
    $scope.listRecipeIngredient.splice(index, 1)


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
        datacontext.createIngredient name: $scope.name
        $scope.$broadcast 'ReloadIngredient', 'Some data'
        # reinitialize attribute
        $scope.name = ""

  $scope.addRecipe = ->
    listRecipeIngredientToSend = []
    #listIngredientToSend = []
    if !$scope.recipe.title or $scope.recipe.title == '' or !$scope.recipe.description or $scope.recipe.description == ''
      Notification.info( 'You need to enter required information!' )
    else
      for ingredRecipe, i in $scope.listRecipeIngredient
        #listIngredientToSend.push(ingredRecipe.ingredient)
        if ingredRecipe.measure == 1
          object =
            ingredient_id : ingredRecipe.ingredient.id
            recipe_id     : null
            quantity      : ingredRecipe.quantity
            measure       : ingredRecipe.measure
            mass_unit     : ingredRecipe.unit
            volume_unit   : null
        else
          if ingredRecipe.measure == 2
            object =
              ingredient_id : ingredRecipe.ingredient.id
              recipe_id     : null
              quantity      : ingredRecipe.quantity
              measure       : ingredRecipe.measure
              mass_unit     : null
              volume_unit   : ingredRecipe.unit
          else
            object =
              ingredient_id : ingredRecipe.ingredient.id
              recipe_id     : null
              quantity      : ingredRecipe.quantity
              measure       : ingredRecipe.measure
              mass_unit     : null
              volume_unit   : null
        listRecipeIngredientToSend.push(object)

      if !recipe
        datacontext.createRecipe(
          title: $scope.recipe.title
          description: $scope.recipe.description,
          listRecipeIngredientToSend).success( (data) ->
            uploader.onBeforeUploadItem = (item)->
              item.formData.push( "recipe_id": data.id, "image_name": item.file.name )
              #console.info 'onBeforeUploadItem', item
              #item.upload()
            uploader.uploadAll()
            $rootScope.$broadcast 'ReloadRecipe', 'Some data')

        $scope.recipe.title         = ''
        $scope.recipe.description   = ''
        $scope.listRecipeIngredient = []

      else
        datacontext.updateRecipe
          id: recipe.id
          title: $scope.recipe.title
          description: $scope.recipe.description




  $scope.deleteIngredientFromList = (obj) ->
    index = $scope.listRecipeIngredient.indexOf(obj)
    $scope.listRecipeIngredient.splice(index, 1)


  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'

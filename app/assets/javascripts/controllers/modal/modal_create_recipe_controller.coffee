@cooking.controller 'ModalCreateRecipeController', ($scope, $rootScope, $modalInstance, datacontext, Notification, volumes, weights, measures, UploaderImage) ->

  $scope.name =                 ''
  $scope.selectedIngredient =   []
  $scope.listRecipeIngredient = []
  $scope.ingredients =          []

  $scope.volumes =              volumes
  $scope.weights =              weights
  $scope.measures =             measures
  $scope.chosenMeasure =        $scope.weights
  $scope.measure =              $scope.measures[0].id
  $scope.unit =                 $scope.weights[0].id

  $scope.uploader = uploader = UploaderImage.uploader_image()
  $scope.loadUploader = true

  $scope.modalTitle  = 'Ajouter une recette'
  $scope.recipe =
    title:        ""
    description:  ""

  datacontext.getIngredients().success( ( data ) ->
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
          obj =
            ingredient :  ingred
            quantity :    quantity
            unit :        unit
            measure :     measure
          $scope.listRecipeIngredient.push( obj )


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

  $scope.addRecipe = ->
    listRecipeIngredientToSend = []
    #listIngredientToSend = []
    if !$scope.recipe.title or $scope.recipe.title == '' or !$scope.recipe.description or $scope.recipe.description == ''
      Notification.info( 'You need to enter required information!' )
    else
      for ingredRecipe, i in $scope.listRecipeIngredient
        if ingredRecipe.measure == 1
          object =
            ingredient_id : ingredRecipe.ingredient.id
            recipe_id :     null
            quantity :      ingredRecipe.quantity
            measure :       ingredRecipe.measure
            mass_unit :     ingredRecipe.unit
            volume_unit :   null
        else
          if ingredRecipe.measure == 2
            object =
              ingredient_id : ingredRecipe.ingredient.id
              recipe_id :     null
              quantity :      ingredRecipe.quantity
              measure :       ingredRecipe.measure
              mass_unit :     null
              volume_unit :   ingredRecipe.unit
          else
            object =
              ingredient_id : ingredRecipe.ingredient.id
              recipe_id :     null
              quantity :      ingredRecipe.quantity
              measure :       ingredRecipe.measure
              mass_unit :     null
              volume_unit :   null
        listRecipeIngredientToSend.push( object )
      datacontext.createRecipe(
        title: $scope.recipe.title
        description: $scope.recipe.description,
        listRecipeIngredientToSend).success( ( data ) ->
          uploader.onBeforeUploadItem = ( item )->
            item.formData.push( "recipe_id": data.id, "image_name": item.file.name )
          uploader.uploadAll()
          $rootScope.$broadcast 'ReloadRecipe', 'Some data'
          $scope.cancel())


  $scope.deleteIngredientFromList = ( obj ) ->
    index = $scope.listRecipeIngredient.indexOf( obj )
    $scope.listRecipeIngredient.splice( index, 1 )


  $scope.cancel = ->
    $modalInstance.dismiss 'cancel'

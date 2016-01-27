@cooking.controller 'homeCtrl', ($scope, datacontext, $modal, toaster, $rootScope) ->
  
  
  #GET all recipes
  datacontext.getRecipes().success((data) ->
    $rootScope.recipes = data.recipes
  ).error (data, status) ->
    alert 'Error on getting recipes'
    
  
  #Refrech list after adding new recipe
  $rootScope.$on 'ReloadRecipe', (event, data) ->
    datacontext.getRecipes().success (data) ->
      $rootScope.recipes = data.recipes
 
  ###***************Modal Recipe*********************###
  
  $scope.OpenModalRecipe = (action,entity) ->
    $rootScope.action = action
    modalInstance = $modal.open(
      templateUrl: 'assets/templates/home/ModalRecipe.html'
      controller: [
        '$scope'
        '$rootScope'
        '$modalInstance'
        'datacontext'
        'toaster'
        ($scope, $rootScope, $modalInstance, datacontext,toaster) ->
        
          $scope.name = ''
          $scope.multiselect = {}
          $scope.multiselect.ingredient = []
          $scope.ListRecipeIngredient = []
          $scope.Ingredients = []
          $scope.Recipe = 
            title : ""
            description : ""
          $scope.Volumes = [
            {
              Id: 1
              Name: 'ml'
            }
            {
              Id: 2
              Name: 'cl'
            }
            {
              Id: 3
              Name: 'litre'
            }
          ]
          $scope.Weights = [
            {
              Id: 1
              Name: 'g'
            }
            {
              Id: 2
              Name: 'Kg'
            }
          ]
          $scope.Measures = [
            {
              Id: 1
              Name: 'Mass'
            }
            {
              Id: 2
              Name: 'Volume'
            }
            {
              Id: 3
              Name: 'None'
            }
          ]
          
          # Get all ingredients
          datacontext.getIngredients().success((data) ->
            #alert('ingredient')
            $scope.Ingredients = data
          ).error (data, status) ->
            alert 'Error on getting ingredients'
          
 
          $scope.AddIngredient = ->
            if $scope.name == '' or $scope.name == undefined
              toaster.pop 'info', 'Validation', 'You need to enter ingredient name!'
            else
              sameIngredientName = $scope.Ingredients.filter(( (x) ->
                x.name == $scope.name
              ))
              if sameIngredientName.length > 0
                toaster.pop 'warning', 'Validation', 'Already ingredient with this same name exist!'
              else
                datacontext.createIngredient name: $scope.name
                $rootScope.$broadcast 'ReloadIngredient', 'Some data'
                # reinitialize attribute
                $scope.name = ""

          # Listner to reload ingredients on each new create of ingredient
          $rootScope.$on 'ReloadIngredient', (event, data) ->
            datacontext.getIngredients().success (data) ->
              $scope.Ingredients = data
		    
          $scope.cancel = ->
            $modalInstance.dismiss 'cancel'

          # Init scope var
          $scope.ChosenMeasure = $scope.Weights
          $scope.measure = $scope.Measures[0].Id
          $scope.unit = $scope.Weights[0].Id
          $scope.ChangeMeasure = ->
            if $scope.measure == 1
              $scope.ChosenMeasure = $scope.Weights
              $scope.unit = $scope.Weights[0].Id
            if $scope.measure == 2
              $scope.ChosenMeasure = $scope.Volumes
              $scope.unit = $scope.Volumes[0].Id
          
          
          $scope.onFileSelect = ($files) ->
            i = 0
            while i < $files.length
              $scope.$file = $files[i]
              i++
          
         
          $scope.AddRecipe = ->
            ListRecipeIngredientToSend = []
            if !$scope.Recipe.title or $scope.Recipe == '' or !$scope.Recipe.description or $scope.Recipe.description == ''
              toaster.pop 'info', 'Validation', 'You need to enter required information!'
            else
              for ingredRecipe, i in $scope.ListRecipeIngredient
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
                ListRecipeIngredientToSend.push(object)  
              datacontext.createRecipe
                title: $scope.Recipe.title
                description: $scope.Recipe.description,
                ListRecipeIngredientToSend     
              $rootScope.$broadcast 'ReloadRecipe', 'Some data'
              # reinitialize attribute
              $scope.Recipe.title         = ''
              $scope.Recipe.description   = ''
              $scope.ListRecipeIngredient = []
              
          $scope.AddTolistIngredient = (ingred, quantity, measure,unit) ->
            if quantity == "" or quantity == undefined  or ingred == undefined
              toaster.pop 'info', 'Validation', 'Please enter all informations'
            else 
              if quantity == 0 
                toaster.pop 'warning', 'Validation', 'Quantity should be greater than 0!'
              else
                existingIngredient = $scope.ListRecipeIngredient.filter(( (x) ->
                  x.ingredient.name == ingred.name
                ))
                if existingIngredient.length > 0
                  toaster.pop 'warning', 'Validation', 'Already '+ingred.name+' exists!'
                else
                  obj =
                    ingredient : ingred
                    quantity : quantity
                    unit : unit
                    measure : measure
                  $scope.ListRecipeIngredient.push(obj)
                  
                  
          $scope.deleteIngredientFromList = (obj) ->
            index = $scope.ListRecipeIngredient.indexOf(obj)
            $scope.ListRecipeIngredient.splice(index, 1)
             
      ]
      size: 'lg')
    modalInstance.result.then ((selectedItem) ->
      console.log selectedItem
    ), ->

@cooking.service "GetModal", ( $modal ) ->

  @recipe = (item) ->
    modalInstance = $modal.open
      templateUrl: 'assets/templates/modals/modal_recipe.html'
      controller:  'ModalRecipeController'
      size:        'lg'
      resolve:
        recipe: -> item

  return

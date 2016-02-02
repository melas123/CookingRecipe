@cooking.service "GetModal", ( $modal ) ->

  @create_recipe = ->
    modalInstance = $modal.open
      templateUrl: 'assets/templates/modals/modal_recipe.html'
      controller:  'ModalCreateRecipeController'
      size:        'lg'

  @edit_recipe = ( item ) ->
    modalInstance = $modal.open
      templateUrl: 'assets/templates/modals/modal_recipe.html'
      controller:  'ModalEditRecipeController'
      size:        'lg'
      resolve:
        recipe: -> item

  return

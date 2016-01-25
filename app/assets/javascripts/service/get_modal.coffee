@cooking.service "GetModal", ( $uibModal ) ->

  @create_recipe = ->
    modalInstance = $uibModal.open
      templateUrl: 'assets/templates/modals/modal_recipe.html'
      controller:  'ModalCreateRecipeController'
      size:        'lg'

  @edit_recipe = ( item ) ->
    modalInstance = $uibModal.open
      templateUrl: 'assets/templates/modals/modal_recipe.html'
      controller:  'ModalEditRecipeController'
      size:        'lg'
      resolve:
        recipe: -> item

  return

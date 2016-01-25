@cooking.directive 'recipeDetails', ->
  restrict: 'E'
  scope:
    recipe: '='
  controller: [
    '$scope'
    ( $scope, Auth, GetModal ) ->

      $scope.isAuthenticated = ->
        return Auth.isAuthenticated()

      $scope.openModalCreateRecipe = ->
        GetModal.create_recipe()

      $scope.openModalEditRecipe = ( recipe ) ->
        GetModal.edit_recipe( recipe )

  ]
  templateUrl: 'assets/templates/directives/recipeElements.html'

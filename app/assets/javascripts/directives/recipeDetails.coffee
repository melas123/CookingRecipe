@cooking.directive 'myRecipe', ->
  {
  restrict: 'E'
  scope:
    recipe: '='
  controller: [
    '$scope'
    ( $scope ) ->
      $scope.details = ->
        console.log( $scope.recipe )
        return true
      return
  ]
  templateUrl: 'assets/templates/directives/recipeTemplate.html'
  }

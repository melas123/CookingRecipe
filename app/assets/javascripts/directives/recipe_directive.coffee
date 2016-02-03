@cooking.directive 'recipeDirective',(Profile,$log)->
  templateUrl: 'assets/templates/home/recipe.html.haml'
  restrict: 'E'
  link: (scope, element) ->

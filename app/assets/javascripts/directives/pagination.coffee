@cooking.directive 'recipePagination', ->
  {
  restrict: 'E'
  scope:
    from: '='
    to: '='
    total: '='
    currentPage: '='
    action: '&'
  controller: [
    '$scope'
    ( $scope ) ->
      $scope.previousPage = ->
        if $scope.currentPage <= 1
          #return false if we are in the first page
          return false
        else
          $scope.currentPage -= 1
          #pass to previous page
          $scope.action page: $scope.currentPage , search: $scope.searchQuery
          return true

      $scope.nextPage = ->
        if $scope.total == $scope.to
          return false
        else
          $scope.currentPage += 1
          $scope.action page: $scope.currentPage , search: $scope.searchQuery
          return true
  ]
  templateUrl: 'assets/templates/directives/paginationElements.html'
  }

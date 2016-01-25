@cooking.directive 'myPagination', ->
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
          console.log( $scope.currentPage )
          #return false if we are in the first page
          return false
        else
          $scope.currentPage -= 1
          #pass to previous page
          $scope.action page: $scope.currentPage
          console.log( $scope.currentPage )
          return true

      $scope.nextPage = ->
        if $scope.total == $scope.to
          console.log( $scope.currentPage )
          return false
        else
          $scope.currentPage += 1
          console.log( $scope.currentPage )
          $scope.action page: $scope.currentPage
          return true
      return
  ]
  templateUrl: 'assets/templates/directives/paginationElements.html'
  }

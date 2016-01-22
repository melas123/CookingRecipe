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
                ($scope) ->

                  $scope.previousPage = ->
                    $scope.currentPage -= 1
                    $scope.action page: $scope.currentPage
                    return

                  $scope.nextPage = ->
                    $scope.currentPage += 1
                    $scope.action page: $scope.currentPage
                    return

                  return
              ]
  #templateUrl: 'assets/templates/paginationElements.html'
  }
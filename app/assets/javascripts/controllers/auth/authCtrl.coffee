@cooking.controller 'authCtrl', ($scope, $rootScope, Auth, $location) ->
  $scope.login = ->
    Auth.login( $scope.user ).then ->
      $location.path 'home'
      $rootScope.auth = Auth.isAuthenticated()   

  $scope.register = ->
    Auth.register( $scope.user ).then ->
      $location.path 'home'
      $rootScope.auth = Auth.isAuthenticated()   

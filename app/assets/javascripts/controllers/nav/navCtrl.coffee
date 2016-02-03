@cooking.controller 'navCtrl', ($scope, $rootScope, Auth,$route) ->

  $scope.$route = $route;
  $scope.signedIn = Auth.isAuthenticated
  $scope.logout   = Auth.logout

  $scope.$on 'devise:new-registration', (e, user) ->
    $scope.user = user

  $scope.$on 'devise:login', (e, user) ->
    $scope.user = user

  $scope.$on 'devise:logout', (e, user) ->
    $scope.user = {}

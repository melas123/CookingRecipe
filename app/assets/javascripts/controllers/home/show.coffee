@cooking.controller 'showCtrl', ($scope, $routeParams,Auth) ->
  Auth.currentUser().then  (user) ->
    $scope.user = user
  $scope.id = $routeParams.id;
  $scope.recipe = {
      id:1,
      title:"recipe 1",
      description:"SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal: SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal:",
      username:"Mohamed Belaid"
      }
  $scope.ingridients = [{id:1,name:"huile"},{id:1,name:"oeuf"}]

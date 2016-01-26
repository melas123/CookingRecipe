@cooking.controller 'profileCtrl', ($scope, Auth) ->
  Auth.currentUser().then  (user) ->
    $scope.user = user
    $scope.recipes = [
      {
        id:1,
        title:"recipe 1",
        description:"SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal: SmartOS images come with pkgsrc pre-installed. On other illumos distributions, first install pkgsrc, then you may install the binary package as normal:",
        username:"Mohamed Belaid"
        },
      {
        id:2,
        title:"recipe 2",
        description:"distributions, first install pkgsrc, then you may install the binary package as normal: SmartOS images come with pkgsrc pre-installed. On other illumos distributionse binary package as normal:",
        username:"Doniya Sfaxienne"
        }
      ]

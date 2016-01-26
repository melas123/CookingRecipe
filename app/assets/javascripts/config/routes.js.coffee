@cooking.config ( $routeProvider ) ->

  $routeProvider

  .when "/login",
    controller:  'authCtrl'
    templateUrl: 'assets/templates/auth/_login.html'

  .when "/register",
    controller:  'authCtrl'
    templateUrl: 'assets/templates/auth/_register.html'

  .when "/home",
    controller:  'homeCtrl'
    templateUrl: 'assets/templates/home/index.html'
    activetab: 'home'

  .when "/profile",
    controller:  'profileCtrl'
    templateUrl: 'assets/templates/profile/profile.html'
    activetab: 'profile'

  .when "/show",
    controller:  'showCtrl'
    templateUrl: 'assets/templates/home/show.html'

  .otherwise redirectTo: "/home"

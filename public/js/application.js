  // create the module and name it scotchApp
  angular.module('Snapr', ['ngRoute', 'ngResource'])

  // .config(function($routeProvider) {
  //   $routeProvider
  //     .when('/', {
  //       controller: 'Ctrl',
  //       templateUrl: 'partials/blah.html'
  //     })
  // })
  // .controller('Ctrl', function() {

  // })

  // configure our routes
  .config(function($routeProvider) {
    $routeProvider

      // route for the login page
      .when('/', {
        templateUrl : 'partials/blah.html',
        controller  : 'mainController'
      })

      // route for the user page
      .when('/login', {
        templateUrl : 'partials/login.html',
        controller  : 'loginController'
      })

  //     // route for the profile page
      .when('/user/:id', {
        templateUrl : 'partials/potential_matches.html',
        controller  : 'mainController'
      })

      .when('/user/:id/matches', {
        templateUrl : 'partials/matches.html',
        controller  : 'mainController'
      })

      .when('/signup', {
        templateUrl : 'partials/signup.html',
        controller  : 'mainController'
      });
  })

  // create the controller and inject Angular's $scope
  .controller('mainController', function($scope, $http) {
    // create a message to display in our view
    // $scope.login = function() {
    //   $scope.login_result = $http.post('/').success(function(data){
    //     $scope.login_result = data;
    //   });
  })

  .controller('loginController', function($scope, $http) {
    // create a message to display in our view
    $scope.user = {username: 'user', password: 'pw'};

    $scope.login = function() {
      $scope.login_result = $http.post('/login', {user: $scope.user}, {headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).success(function(data){
        alert('hi');
        // $timeout(function() {
        //   $location.path('/user/:id');
        // })
      })
    }
  })

  // snapr.controller('aboutController', function($scope, , $http) {
  //   $scope.message = 'Look! I am an about page.';
  // });

  // snapr.controller('contactController', function($scope, , $http) {
  //   $scope.message = 'Contact us! JK. This is just a demo.';
  // });

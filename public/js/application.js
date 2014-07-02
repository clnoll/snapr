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
  // app.factory('OAuth', ['$http', function ($http) {

  //   var _SessionID = '';

  //   return {
  //       login: function () {
  //           //Do login ans store sessionID in var _SessionID
  //       },

  //       logout: function () {
  //           //Do logout
  //       },

  //       isLoggedIn: function () {
  //           if(_SessionID) {
  //               return true;
  //           }
  //           //redirect to login page if false
  //       }
  //   };

  // }])

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
      .when('/users/:id/feed', {
        templateUrl : 'partials/potential_matches.html',
        controller  : 'feedController',
        controllerAs: 'feed'
      })

      .when('/user/:id/matches', {
        templateUrl : 'partials/matches.html',
        controller  : 'mainController'
      })

      .when('/users/:id/profile', {
        templateUrl : 'partials/profile.html',
        controller  : 'profileController'
      })

      .when('/signup', {
        templateUrl : 'partials/signup.html',
        controller  : 'signUpController'
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

  .controller('loginController', function($scope, $location, $timeout, $http) {
    // create a message to display in our view
    $scope.user = {username: '', password: ''};

    $scope.login = function() {
      $scope.login_result = $http.post('/login', {user: $scope.user}, {headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).success(
        function(data){
        $timeout(function() {
          $location.path('/users/' + data.user_id + '/feed');
        })
      })
    }
  })

  .controller('feedController', function($scope, $http, $routeParams ) {
    var id = $routeParams['id']; // find id based off the parameter
    $scope.users = []

    $http.get('/users/' + id + '/feed')
    .success(
      function(data) {

        $scope.users = data;
        // 9 divs showing 9 different user profiles
      })
    })

  .controller('signUpController', function($scope, $location, $timeout, $http) {
    $scope.user = {username: '', password: ''};

    $scope.signup = function() {
      $scope.signup_result = $http.post('/signup', {user: $scope.user}, {headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).success(
        function(data){
        $timeout(function() {
          $location.path('/users/' + data.user_id + '/feed');
        })
      })
    }
  })

  .controller('profileController', function($scope, $location, $timeout, $http, $routeParams) {
    $scope.user = {username: '', age: '', city: '', state: '', gender: '', gender_pref: '', description: ''};
    var id = $routeParams['id'];
    $scope.profile = function() {
      $scope.profile_result = $http.post('/users/' + id + '/profile', {user: $scope.user}, {headers: {'Content-Type': 'application/x-www-form-urlencoded'}}).success(
        function(data){
        $timeout(function() {
          $location.path('/users/' + data.user_id + '/feed');
        })
      })
    }
  });

  // snapr.controller('contactController', function($scope, , $http) {
  //   $scope.message = 'Contact us! JK. This is just a demo.';
  // });

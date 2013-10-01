'use strict'

App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'todo'
  'apartments'
  'main.controllers'
  'main.directives'
  'main.filters'
  'main.services'
  'partials'
])

App.config(($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/todo', {templateUrl: '/_public/js/todo/todo.html'})
    .when('/view1', {templateUrl: '/_public/js/main/partial1.html'})
    .when('/list', {templateUrl: '/_public/js/apartments/list.html'})
    # Catch all
    .otherwise({redirectTo: '/todo'})
  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(true)
)

# Declare app level module which depends on filters, and services
angular.module('main.controllers', [])
angular.module('main.directives', ['main.services'])
angular.module('main.filters', [])
angular.module('main.services', [])

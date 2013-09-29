'use strict'

# Declare app level module which depends on filters, and services
App = angular.module('app', [
  'ngCookies'
  'ngResource'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
  'partials'
])

App.config(($routeProvider, $locationProvider) ->
  $routeProvider
    .when('/todo', {templateUrl: '/partials/todo.html'})
    .when('/view1', {templateUrl: '/partials/partial1.html'})
    .when('/list', {templateUrl: '/partials/list.html'})
    # Catch all
    .otherwise({redirectTo: '/todo'})
  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(true)
)

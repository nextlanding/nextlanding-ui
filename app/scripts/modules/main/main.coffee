'use strict'

App = angular.module('app', [
  'todo'
  'apartments'
  'search'
  'main.controllers'
  'main.directives'
  'main.filters'
  'main.services'
  'partials'
  'ngRoute'
  'restangular'
])

App.config(($routeProvider) ->
  $routeProvider
  .when('/todo', {templateUrl: '/_public/js/todo/todo.html'})
  .when('/view1', {templateUrl: '/_public/js/main/partial1.html'})
  .when('/list', {templateUrl: '/_public/js/apartments/list.html'})
  .when('/search', {templateUrl: '/_public/js/search/start.html'})
  # Catch all
  .otherwise({redirectTo: '/todo'})
)

App.config(($locationProvider) ->
  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(true)
)

App.config((RestangularProvider) ->
  RestangularProvider.setBaseUrl('http://localhost:8000/api/')

  # This function is used to map the JSON data to something Restangular expects
  # http://stackoverflow.com/a/17386402/173957
  RestangularProvider.setResponseExtractor (response, operation, what, url) ->
    if operation == "getList"

      # Use results as the return type, and save the result metadata
      # in _resultmeta
      newResponse = response.results
      newResponse._resultMeta =
        count: response.count
        next: response.next
        previous: response.previous

      newResponse
    else
      response
)

# Declare app level module which depends on filters, and services
angular.module('main.controllers', [])
angular.module('main.directives', ['main.services'])
angular.module('main.filters', [])
angular.module('main.services', [])

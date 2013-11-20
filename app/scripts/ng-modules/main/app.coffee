'use strict'

App = angular.module('app', [
  'apartment'
  'search'
  'googleMaps'
  'app.controllers'
  'app.directives'
  'app.filters'
  'app.services'
  'partials'
  'stripe'
  'ngAnimate'
  'ui.router'
  'ui.bootstrap'
  'ui.utils'
  'lodash'
])

App.config ($stateProvider, $urlRouterProvider) ->
  $urlRouterProvider.otherwise "/"

  $stateProvider.state "home",
    url: "/"
    templateUrl: "/_public/js/main/home.html"
    data:
      style:
        webAppStyle: false
  .state "styles",
      url: "/styles"
      templateUrl: "/_public/js/main/partial1.html"
  .state "contact",
    url: "/contact"
    templateUrl: "/_public/js/main/thank-you.html"
    data:
      style:
        webAppStyle: true
  .state "search",
    url: "/search"
    templateUrl: "/_public/js/search/wizard/start.html"
    data:
      style:
        webAppStyle:true


App.config(($locationProvider) ->
  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(true)
)

App.config((RestangularProvider, AppConfig) ->
  RestangularProvider.setBaseUrl AppConfig.API_ENDPOINT
  RestangularProvider.setDefaultHttpFields
    withCredentials: true



  # This function is used to map the JSON data to something Restangular expects
  # http://stackoverflow.com/a/17386402/173957
  RestangularProvider.setResponseExtractor (response, operation, what, url) ->
    if operation is "getList" and response.results?

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
angular.module('app.controllers', [])
angular.module('app.directives', ['app.services'])
angular.module('app.filters', [])
angular.module('app.services', [])

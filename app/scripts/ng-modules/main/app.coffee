'use strict'

App = angular.module('app', [
  'apartment'
  'search'
  'admin'
  'result'
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
  'analytics'
  'momentjs'
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
  .state "thankYou",
      url: "/thank-you"
      templateUrl: "/_public/js/main/thank-you.html"
      data:
        style:
          webAppStyle: true
  .state "search",
      url: "/search"
      templateUrl: "/_public/js/search/wizard/start.html"
      data:
        style:
          webAppStyle: true
  .state "results",
      url: "/results/:searchId"
      templateUrl: "/_public/js/result/list-apartments.html"
      data:
        style:
          webAppStyle: true

  .state "admin",
      url: "/admin"
      templateUrl: "/_public/js/admin/admin.html"
      data:
        style:
          webAppStyle: true
          AdminStyle: true
  .state "admin.emailerSender",
      url: "/emailer/sender/:searchId"
      templateUrl: "/_public/js/admin/emailer-sender.html"
  .state "admin.startCrawl",
      url: "/crawl"
      templateUrl: "/_public/js/admin/create-crawl.html"
  .state "admin.addApartments",
      url: "/add-apartments/:searchId"
      templateUrl: "/_public/js/admin/add-apartments.html"

  .state "aboutus",
      url: "/about-us"
      templateUrl: "/_public/js/main/about-us.html"
      data:
        style:
          webAppStyle: true
  .state "tos",
      url: "/tos"
      templateUrl: "/_public/js/main/tos.html"
  .state "howitworks",
      url: "/how-it-works"
      templateUrl: "/_public/js/main/how-it-works.html"

App.config(($locationProvider) ->
  # Without server side support html5 must be disabled.
  $locationProvider.html5Mode(true)
)

App.config((StripeProvider, AppConfig) ->
  StripeProvider.setPublishableKey(AppConfig.STRIPE_PUBLIC_KEY)
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

  #https://github.com/mgonto/restangular#how-can-i-access-the-unrestangularized-element-as-well-as-the-restangularized-one
  RestangularProvider.setResponseExtractor (response) ->
    newResponse = response
    if angular.isArray(response)
      newResponse.originalElement ||= {}
      angular.forEach newResponse, (value, key) ->
        newResponse.originalElement[key] = angular.copy(value)
    else
      newResponse.originalElement = angular.copy(response)
    newResponse
)

App.run ($rootScope, $location, Analytics, AppConfig) ->
  Analytics.init mixpanel: AppConfig.MIXPANEL_ID, googleAnalytics: AppConfig.GOOGLE_ANALYTICS_ID

  $rootScope.$on "$stateChangeSuccess", (event, toState) ->
    unless /admin/.test(toState.name)
      Analytics.trackPageView toState.name, $location.path()

  $rootScope.$on "tracking:user:signup", (event, userProps) ->
    Analytics.userSignup userProps

  $rootScope.$on "tracking:user:purchase", (event, amount, product) ->
    Analytics.trackCharge amount, product
    Analytics.trackEvent "Purchased", {Amount: amount, Product: product}

# Declare app level module which depends on filters, and services
angular.module('app.controllers', [])
angular.module('app.directives', ['app.services'])
angular.module('app.filters', [])
angular.module('app.services', [])

'use strict'

# Declare app level module which depends on filters, and services
search = angular.module('search', [
  'search.controllers'
  'search.directives'
  'search.filters'
  'search.services'
  'restangular'
  'angularPayments'
])

angular.module('search.controllers', ['googleMaps'])
angular.module('search.directives', [])
angular.module('search.filters', [])
angular.module('search.services', ['restangular'])

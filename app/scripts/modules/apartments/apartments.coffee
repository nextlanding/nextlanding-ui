'use strict'

# Declare app level module which depends on filters, and services
apartments = angular.module('apartments', [
  'ngCookies'
  'ngResource',
  'apartments.controllers'
  'apartments.directives'
  'apartments.filters'
  'apartments.services'
])

angular.module('apartments.controllers', [])
angular.module('apartments.directives', [])
angular.module('apartments.filters', [])
angular.module('apartments.services', [])

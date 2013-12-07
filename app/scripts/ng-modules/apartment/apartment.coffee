'use strict'

# Declare app level module which depends on filters, and services
angular.module('apartment', [
  'apartment.controllers'
  'apartment.directives'
  'apartment.filters'
  'apartment.services'
])

angular.module('apartment.controllers', ['ui.bootstrap'])
angular.module('apartment.directives', [])
angular.module('apartment.filters', [])
angular.module('apartment.services', [])

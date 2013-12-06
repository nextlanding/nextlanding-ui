'use strict'

# Declare app level module which depends on filters, and services
angular.module('result', [
  'result.controllers'
  'result.directives'
  'result.filters'
  'result.services'
])

angular.module('result.controllers', ['googleMaps'])
angular.module('result.directives', [])
angular.module('result.filters', [])
angular.module('result.services', [])

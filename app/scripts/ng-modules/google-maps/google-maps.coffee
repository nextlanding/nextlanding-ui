'use strict'

# Declare app level module which depends on filters, and services
search = angular.module('googleMaps', [
  'googleMaps.controllers'
  'googleMaps.directives'
  'googleMaps.filters'
  'googleMaps.services'
  'ui.map'
])

angular.module('googleMaps.controllers', [])
angular.module('googleMaps.directives', ['ui.map'])
angular.module('googleMaps.filters', [])
angular.module('googleMaps.services', [])

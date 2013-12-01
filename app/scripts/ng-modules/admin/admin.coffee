'use strict'

# Declare app level module which depends on filters, and services
admin = angular.module('admin', [
  'admin.controllers'
  'admin.directives'
  'admin.filters'
  'admin.services'
  'restangular'
])

angular.module('admin.controllers', [])
angular.module('admin.directives', [])
angular.module('admin.filters', [])
angular.module('admin.services', ['restangular'])

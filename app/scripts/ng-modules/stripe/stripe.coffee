'use strict'

# Declare app level module which depends on filters, and services
search = angular.module('stripe', [
  'stripe.controllers'
  'stripe.directives'
  'stripe.filters'
  'stripe.services'
])

angular.module('stripe.controllers', [])
angular.module('stripe.directives', [])
angular.module('stripe.filters', [])
angular.module('stripe.services', [])

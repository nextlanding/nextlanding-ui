'use strict'

angular.module('stripe.directives')
.directive "stripeCheckout", (StripeCheckout, MainConfig) ->
    restrict: 'A'
    transclude: false
    scope:
      amount: '@'
      description: '@'
      image: '@'
      paymentCallback: '&'
    link: (scope, elem, attrs) ->
      elem.on 'click', ->
        StripeCheckout.open
          key: MainConfig.STRIPE_PUBLIC_KEY
          amount: scope.amount
          currency: 'usd'
          name: 'Nextlanding'
          description: scope.description
          image: scope.image
          token: (token) ->
            scope.paymentCallback token:token

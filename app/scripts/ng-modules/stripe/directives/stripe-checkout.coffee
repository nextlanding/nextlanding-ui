'use strict'

angular.module('stripe.directives')
.directive "stripeCheckout", (StripeCheckout, AppConfig) ->
    restrict: 'A'
    transclude: false
    scope:
      amount: '@'
      description: '@'
      image: '@'
      paymentCallback: '&'
    link: (scope, elem, attrs) ->
      elem.on 'click', ->
        elem.attr('disabled', 'disabled')
        StripeCheckout.open
          key: AppConfig.STRIPE_PUBLIC_KEY
          amount: scope.amount
          currency: 'usd'
          name: 'Nextlanding'
          description: scope.description
          image: scope.image
          closed: ->
            elem.removeAttr('disabled')
          token: (token) ->
            scope.$apply(-> scope.paymentCallback token: token)

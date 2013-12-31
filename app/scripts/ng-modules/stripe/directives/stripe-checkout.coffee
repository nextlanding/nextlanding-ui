'use strict'

angular.module('stripe.directives')
.directive "stripeCheckout", (StripeCheckout, AppConfig) ->
    restrict: 'A'
    transclude: false
    scope:
      amount: '@'
      description: '@'
      image: '@'
      email: '@'
      paymentCallback: '&'
    link: (scope, elem, attrs) ->
      amountInCents = parseInt(scope.amount * 100)

      elem.on 'click', ->
        displayCheckout()

      scope.$on "payment:checkout:display", (event, args)->
        displayCheckout()

      displayCheckout =  ->
        elem.attr 'disabled', 'disabled'
        StripeCheckout.open
          key: AppConfig.STRIPE_PUBLIC_KEY
          amount: amountInCents
          currency: 'usd'
          name: 'Nextlanding'
          email: scope.email
          description: scope.description
          image: scope.image
          closed: ->
            (scope.$apply ->
              elem.removeAttr 'disabled') unless scope.paid?
          token: (token) ->
            #there is a bug with stripe checkout where it will fire multiple `token` callbacks
            unless scope.paid
              scope.$apply ->
                scope.paid = true
                scope.paymentCallback token: token

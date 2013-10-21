'use strict'

angular.module('stripe.directives')
.directive "stripeCheckout", (Stripe, MainConfig) ->
    restrict: 'E'
    replace: true
    template: "<div></div>"
    scope:
      amount: '@',
      description: '@',
      image: '@',
    link: (scope, elem, attrs) ->
      scriptString = "<script src='https://checkout.stripe.com/v2/checkout.js' class='stripe-button'
                      data-key='#{MainConfig.STRIPE_PUBLIC_KEY}'
                      data-amount='#{scope.amount}'
                      data-name='Nextlanding'
                      data-description='#{scope.description}'
                      data-currency='usd'
                      data-image='#{scope.image}'>
                      </script>"

      elem.append scriptString

'use strict'

angular.module('stripe.services')
.factory "StripeCheckout", ->
    window.StripeCheckout
.provider "Stripe", ->
    # angular will throw an error if you have a return value that is not a hash containing a $get func
    # Ex: must define $get factory method.

    $get: ->
      window.Stripe
    setPublishableKey: (key) ->
      window.Stripe.setPublishableKey key

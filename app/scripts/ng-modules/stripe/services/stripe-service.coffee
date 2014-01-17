'use strict'

angular.module('stripe.services')
.factory "StripeCheckout", ->
    window.StripeCheckout
.provider "Stripe", ->
    @$get = ->
      window.Stripe

    @setPublishableKey = (key) ->
      window.Stripe.setPublishableKey key

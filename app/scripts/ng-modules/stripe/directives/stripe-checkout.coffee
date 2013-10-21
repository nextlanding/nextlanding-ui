'use strict'

angular.module('stripe.directives')
.directive "stripeCheckout", (Stripe, MainConfig) ->
    restrict: 'E'
    replace: true
    template: "<div></div>"
    scope:
      alertText: '@',
      children: '=',
      shout: '&'
    link: (scope, elem, attrs) ->
      $.ajaxSetup({'cache': true})
      # the script tag cannot be put into the template because it won't work
      # https://github.com/angular/angular.js/issues/4555
#      script = document.createElement "script"
#      script.type = "text/javascript"
#      script.src = "https://checkout.stripe.com/v2/checkout.js"
#      dataElem = angular.element(elem)
#      dataElem.addClass("stripe-button")
#      dataElem.data('key', MainConfig.STRIPE_PUBLIC_KEY)
#      dataElem.data('amount', 3500)
#      dataElem.attr('data-name', 'Search')
#      dataElem.description = "Nextlanding Search Service"
#      dataElem.currency = "usd"
      console.log('test')
      elem.append '<script  src="https://checkout.stripe.com/v2/checkout.js?_=1382333016456" class="stripe-button"  data-key="pk_test_czwzkTp2tactuLOEOqbMTRzG"  data-amount="2000"  data-name="Demo Site"  data-description="2 widgets ($20.00)"  data-currency="usd"  data-image="/128x128.png"></script>'

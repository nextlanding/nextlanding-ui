'use strict'

angular.module('search.controllers')
.controller "SearchWizardPaymentCtrl", ($scope, SearchWizardModel, $element) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:paymentStep", ->
      $scope.currentStep.form = $scope.paymentStepForm

    $scope.$on "search:complete", ->
      # this is bad - using the $element is bad practice in angular. The problem is the angular-payments module is bound to the
      # 'submit' event on the form. This is bad, they should use something better - like events.
      $element.submit()

    $scope.handleStripe = (status, response) ->
      if response.error
        alert response
        $scope.model.cancelPayment()
      else
        token = response.id
        $scope.model.processPayment(token)

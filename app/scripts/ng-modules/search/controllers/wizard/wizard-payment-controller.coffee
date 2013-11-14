'use strict'

angular.module('search.controllers')
.controller "SearchWizardPaymentCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:paymentStep", ->
      $scope.currentStep.form = $scope.paymentStepForm

    $scope.paymentCallback = (token) ->
      debugger
      console.log token

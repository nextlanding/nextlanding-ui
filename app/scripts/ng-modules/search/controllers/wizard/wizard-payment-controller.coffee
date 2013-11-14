'use strict'

angular.module('search.controllers')
.controller "SearchWizardPaymentCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.token = {value: null}

    $scope.$on "currentStep:changed:paymentStep", ->
      #we never really want the submit button to be enabled
      $scope.paymentStepForm.$setValidity 'token', false
      $scope.currentStep.form = $scope.paymentStepForm

    $scope.paymentCallback = (token) ->
      $scope.token.value = token

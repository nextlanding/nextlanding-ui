'use strict'

angular.module('search.controllers')
.controller "SearchWizardPaymentCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.token = {value: null}

    $scope.$on "currentStep:changed:paymentStep", ->
      setPaymentValidity()
      $scope.currentStep.form = $scope.paymentStepForm

    $scope.paymentCallback = (token) ->
      $scope.token.value = token
      setPaymentValidity()

    setPaymentValidity = ->
      $scope.paymentStepForm.$setValidity 'token', !!$scope.token.value

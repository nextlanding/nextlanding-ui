'use strict'

angular.module('search.controllers')
.controller "SearchWizardContactCtrl", ($scope) ->

    $scope.$watch('currentStep', (currentStep) ->
      if currentStep is 'contactStep'
        $scope.currentStepForm.valid = $scope.contactStepForm.$valid
    )

    $scope.$watch('contactStepForm.$valid', (isValid) ->
      $scope.currentStepForm.valid = isValid
    )

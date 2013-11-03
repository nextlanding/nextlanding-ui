'use strict'

angular.module('search.controllers')
.controller "SearchWizardDescriptionCtrl", ($scope, googleMaps) ->

    $scope.$watch('currentStep', (currentStep) ->
      if currentStep is 'descriptionStep'
        $scope.currentStepForm.valid = $scope.descriptionStepForm.$valid
    )

    $scope.$watch('descriptionStepForm.$valid', (isValid) ->
      $scope.currentStepForm.valid = isValid
    )

'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope) ->
    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]

    #set initial step
    $scope.currentStep = $scope.steps[0]

    $scope.getCurrentStep = -> $scope.currentStep

    $scope.proceed = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) + 1]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

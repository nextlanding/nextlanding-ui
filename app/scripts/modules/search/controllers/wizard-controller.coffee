'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http, Restangular) ->
    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]

    #set initial step
    $scope.currentStep = $scope.steps[0]

    $scope.getCurrentStep = ->
      $scope.currentStep

    $scope.proceed = ->
      nextStep = $scope.steps.indexOf($scope.currentStep) + 1

      if $scope.steps.length == nextStep
        baseSearches = Restangular.all('search')
        baseSearches.getList().then -> console.log(args)
      else
        $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

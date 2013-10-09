'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http, Restangular) ->
    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]
    $scope.search = {}
    #set initial step
    $scope.currentStep = $scope.steps[0]

    $scope.getCurrentStep = ->
      $scope.currentStep

    $scope.proceed = ->
      nextStep = $scope.steps.indexOf($scope.currentStep) + 1

      if $scope.steps.length == nextStep
        console.log($scope.search)
        baseSearches = Restangular.all('search')
        baseSearches.getList().then (search) -> console.log(search)
      else
        $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

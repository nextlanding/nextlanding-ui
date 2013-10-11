'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http, Restangular) ->
    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]
    baseSearches = Restangular.all 'search/init'

    $scope.search = {}

    $scope.currentStep = $scope.steps[0]

    $scope.getCurrentStep = -> $scope.currentStep

    $scope.proceed = ->
      Restangular.one('search/init').get().then (search) -> console.log(search)

      nextStep = $scope.steps.indexOf($scope.currentStep) + 1

      if $scope.steps.length == nextStep
        console.log($scope.search)
        baseSearches.post($scope.search).then -> console.log(arguments)
      else
        $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

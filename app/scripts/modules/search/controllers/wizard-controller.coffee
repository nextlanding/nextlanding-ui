'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http) ->
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
        # this callback will be called asynchronously
        # when the response is available
        $http(
          method: "GET"
          url: "http://localhost:8000/api/search/"
        ).success((data, status, headers, config) ->
          console.log data
        ).error (data, status, headers, config) ->
          # called asynchronously if an error occurs
          # or server returns response with an error status.
      else
        $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

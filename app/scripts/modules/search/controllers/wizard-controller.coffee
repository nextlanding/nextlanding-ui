'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http, Restangular) ->
    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]

    Restangular.one('search/init').get().then (search) ->
      if search?
        searchData = angular.fromJson(search.search_attrs)
        $scope.search = searchData


    $scope.currentStep = $scope.steps[0]

    $scope.getCurrentStep = -> $scope.currentStep

    $scope.proceed = ->
      nextStep = $scope.steps.indexOf($scope.currentStep) + 1

      if $scope.steps.length == nextStep
        baseSearches = Restangular.all 'search/init'
        baseSearches.post($scope.search).then -> console.log(arguments)
      else
        $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]
  )

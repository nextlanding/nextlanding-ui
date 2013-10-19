'use strict'

### Controllers ###

angular.module('search.controllers')
.controller('SearchWizardCtrl', ($scope, $http, Restangular) ->
    searchInitResource = Restangular.one('search/init')

    $scope.search = {} #create parent-level search

    $scope.steps = [
      'locationStep'
      'geographyStep'
      'descriptionStep'
    ]

    $scope.currentStep = $scope.steps[0]

    searchInitResource.get().then (search) ->
      if search?
        saveSearchToScope(search, $scope)

    $scope.getCurrentStep = ->
      $scope.currentStep

    $scope.proceed = ->
      if $scope.search.url
        searchPromise = $scope.search.put()
      else
        searchPromise = Restangular.all('search/init').post($scope.search).then (search) ->
          saveSearchToScope(search, $scope)

      searchPromise.then ->
        nextStep = $scope.steps.indexOf($scope.currentStep) + 1

        if $scope.steps.length == nextStep
          console.log('done')
        else
          $scope.currentStep = $scope.steps[ nextStep]

    $scope.retreat = ->
      $scope.currentStep = $scope.steps[$scope.steps.indexOf($scope.currentStep) - 1]

    saveSearchToScope = (search,scope)->
      search.search_attrs = angular.fromJson search.search_attrs
      scope.search = search
      )

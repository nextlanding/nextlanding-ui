'use strict'

angular.module('search.services')
.factory 'SearchWizardModel', ($rootScope, $timeout, Restangular) ->
    searchInitResource = Restangular.one('search/init')
    search = {}
    steps = [
      'locationStep'
      'descriptionStep'
      'generalDetailsStep'
      'amenityDetailsStep'
      'contactStep'
      'paymentStep'
    ]

    broadcastCurrentStep = ->
      $rootScope.$broadcast "currentStep:changed:#{currentStep}"

    currentStep = steps[0]

    #this needs to be done in the next digest becuase our subscribers won't be registered until then
    $timeout(broadcastCurrentStep)

    proceed = ->
      #      if $scope.search.url
      #        searchPromise = $scope.search.put()
      #      else
      #        searchPromise = Restangular.all('search/init').post($scope.search).then (search) ->
      #          saveSearchToScope(search, $scope)
      #
      #      searchPromise.then ->
      #        nextStep = $scope.steps.indexOf($scope.currentStep) + 1
      nextStep = steps.indexOf(currentStep) + 1

      if steps.length == nextStep
        console.log('done')
      else
        currentStep = steps[nextStep]
        broadcastCurrentStep()

    retreat = ->
      currentStep = steps[steps.indexOf(currentStep) - 1]
      broadcastCurrentStep()

    #this is its own function because of mutability of the current step variable
    getCurrentStep = ->
      currentStep

    search: search
    steps: steps
    getCurrentStep: getCurrentStep
    proceed: proceed
    retreat: retreat

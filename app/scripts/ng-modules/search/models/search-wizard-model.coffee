'use strict'

angular.module('search.services')
.factory 'SearchWizardModel', ($rootScope, $timeout, Restangular) ->
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
      if search.url
        response = search.put()
      else
        response = Restangular.all('search/init').post(search)

      response.then (response) ->
        parseSearch(response)

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

    isLastStep = ->
      getCurrentStep() == steps[steps.length - 1]

    parseSearch = (response) ->
      search = response
      search.search_attrs = angular.fromJson response.search_attrs

    retVal =
      steps: steps
      getCurrentStep: getCurrentStep
      proceed: proceed
      retreat: retreat
      isLastStep: isLastStep
      parseSearch: parseSearch

    # defining a getter property here because the search is constantly replaced by the restangular responses
    # using angular.extend was causing problems with re-writing the object.
    # we could just make search a function called getSearch() but then each template would be look like:
    # <input ng-model='model.getSearch().location.name....
    Object.defineProperty retVal, 'search',
      get: -> search

    retVal

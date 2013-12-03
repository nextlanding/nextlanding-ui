'use strict'

angular.module('search.services')
.factory 'SearchWizardModel', ($rootScope, $timeout, $state, $location, Restangular, Lodash) ->
    search = {}
    amenities = {}
    paymentPending = false
    initFired = false

    steps = [
      'locationStep'
      'descriptionStep'
      'generalDetailsStep'
      'amenityDetailsStep'
      'contactStep'
      'paymentStep'
    ]

    init = ->
      unless initFired
        initFired = true
        #get the initial response
        #we're doing a get to return just 1 item - this is unconventional and requires a .customPUT call later in the model
        Restangular.all('potential_search_init').getList().then (response) ->
          if response
            parseSearch(response)

        Restangular.all('amenity').getList().then (response) ->
          amenities = response

    broadcastCurrentStep = ->
      $rootScope.$broadcast "currentStep:changed:#{currentStep}"

    currentStep = steps[0]

    #this needs to be done in the next digest becuase our subscribers won't be registered until then
    $timeout(broadcastCurrentStep)

    proceed = ->
      if search.id
        #use customput because restangular expects a getList to return multiple items
        #this is a hack to prevent restangular from attachin an id to the path
        response = search.customPUT(angular.extend(search, id: null))
      else
        response = Restangular.all('potential_search_init').post(search)

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

    toggleAmenity = (amenityId) ->
      search.search_attrs.amenities ||= []
      if amenityId in search.search_attrs.amenities
        Lodash.remove(search.search_attrs.amenities, amenityId)
      else
        search.search_attrs.amenities.push amenityId

    processPayment = (token) ->
      search.token = token
      paymentPending = true
      Restangular.all('potential_search_complete').post(search).then (->
        paymentPending = false
        $state.go 'thankYou'
        #find a way to remove the back button - simulate post redirect get
        $location.replace()
      ), ->
        paymentPending = false
        alert ('error processing your payment')


    retVal =
      steps: steps
      init: init
      getCurrentStep: getCurrentStep
      proceed: proceed
      retreat: retreat
      isLastStep: isLastStep
      parseSearch: parseSearch
      toggleAmenity: toggleAmenity
      processPayment: processPayment

    # defining a getter property here because the search is constantly replaced by the restangular responses
    # using angular.extend was causing problems with re-writing the object.
    # we could just make search a function called getSearch() but then each template would be look like:
    # <input ng-model='model.getSearch().location.name....
    Object.defineProperty retVal, 'search',
      get: ->
        search

    Object.defineProperty retVal, 'amenities',
      get: ->
        amenities

    Object.defineProperty retVal, 'paymentPending',
      get: ->
        paymentPending

    retVal

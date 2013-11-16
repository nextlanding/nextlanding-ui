'use strict'

### Controllers ###

angular.module('search.controllers')
.controller 'SearchWizardMainCtrl', ($scope, SearchWizardModel, Restangular) ->
    $scope.model = SearchWizardModel

    $scope.currentStep = {form: null}

    $scope.isCurrentStep = (stepName)->
      $scope.model.getCurrentStep() == stepName

    #get the initial response
    #we're doing a get to return just 1 item - this is unconventional and requires a .customPUT call later in the model
    Restangular.all('potential_search_init').getList().then (response) ->
      if response
        $scope.model.parseSearch(response)

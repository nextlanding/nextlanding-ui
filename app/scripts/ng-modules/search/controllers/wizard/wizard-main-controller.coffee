'use strict'

### Controllers ###

angular.module('search.controllers')
.controller 'SearchWizardMainCtrl', ($scope, SearchWizardModel, Restangular) ->
    $scope.model = SearchWizardModel

    $scope.currentStep= {form:null}

    $scope.isCurrentStep = (stepName)->
      $scope.model.getCurrentStep() == stepName

    #get the initial response
    Restangular.one('search/init').get().then (response) ->
      if response?
        $scope.model.parseSearch(response)

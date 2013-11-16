'use strict'

### Controllers ###

angular.module('search.controllers')
.controller 'SearchWizardMainCtrl', ($scope, SearchWizardModel, Restangular) ->
    $scope.model = SearchWizardModel

    $scope.currentStep = {form: null}

    $scope.isCurrentStep = (stepName)->
      $scope.model.getCurrentStep() == stepName

    $scope.model.init()

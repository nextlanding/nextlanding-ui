'use strict'

angular.module('search.controllers')
.controller "SearchWizardDescriptionCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:descriptionStep", ->
      $scope.currentStep.form = $scope.descriptionStepForm

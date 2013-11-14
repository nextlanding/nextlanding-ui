'use strict'

angular.module('search.controllers')
.controller "SearchWizardGeneralDetailsCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:generalDetailsStep", ->
      $scope.currentStep.form = $scope.generalDetailsStepForm

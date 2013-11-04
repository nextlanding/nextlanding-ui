'use strict'

angular.module('search.controllers')
.controller "SearchWizardContactCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:contactStep", ->
      $scope.currentStep.form = $scope.contactStepForm

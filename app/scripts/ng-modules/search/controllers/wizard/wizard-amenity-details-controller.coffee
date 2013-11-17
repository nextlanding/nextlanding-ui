'use strict'

angular.module('search.controllers')
.controller "SearchWizardAmenityDetailsCtrl", ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:amenityDetailsStep", ->
      $scope.currentStep.form = $scope.amenityDetailsStepForm


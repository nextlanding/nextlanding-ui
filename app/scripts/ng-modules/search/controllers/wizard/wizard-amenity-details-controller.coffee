'use strict'

angular.module('search.controllers')
.controller "SearchWizardAmenityDetailsCtrl", ($scope, SearchWizardModel, Lodash) ->
    $scope.model = SearchWizardModel

    $scope.$on "currentStep:changed:amenityDetailsStep", ->
      $scope.currentStep.form = $scope.amenityDetailsStepForm
    $scope.toggleAmenity = (amenityId) ->
      $scope.model.search.search_attrs.amenities ||= []
      if amenityId in $scope.model.search.search_attrs.amenities
        Lodash.remove($scope.model.search.search_attrs.amenities, amenityId)
      else
        $scope.model.search.search_attrs.amenities.push amenityId

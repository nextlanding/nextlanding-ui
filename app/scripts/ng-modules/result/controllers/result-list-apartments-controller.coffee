'use strict'

angular.module('result.controllers')
.controller 'ResultListApartmentsCtrl', ($scope, $state, Restangular, ApartmentDisplayService, ApartmentDataService) ->
    $scope.model = {}

    Restangular.one('search', $state.params.searchId).all('results').getList().then (response) ->
      $scope.model.config =
        address: response.originalElement.address
        geo_boundary_points: response.originalElement.geo_boundary_points

      $scope.model.apartmentList = response.search_results

      angular.forEach $scope.model.apartmentList, (value, key) ->
        ApartmentDataService.prepareApartmentData(value)

      angular.forEach $scope.model.apartmentList, (value, key) ->
        ApartmentDisplayService.formatApartmentDetails(value)

      $scope.$broadcast('map:location:searched', address: $scope.model.config.address)
      $scope.$broadcast("map:data:retrieved", $scope.model.config.geo_boundary_points)


      $scope.$broadcast("map:markers:retrieved", $scope.model.apartmentList)

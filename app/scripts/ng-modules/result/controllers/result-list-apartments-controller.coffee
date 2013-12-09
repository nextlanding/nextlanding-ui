'use strict'

angular.module('result.controllers')
.controller 'ResultListApartmentsCtrl', ($scope, $state, Restangular, ApartmentDisplayService, ApartmentDataService) ->
    $scope.model = {}

    Restangular.one('search', $state.params.searchId).all('results').getList().then (response) ->
      $scope.model.config =
        address: response.originalElement.address
        geo_boundary_points: response.originalElement.geo_boundary_points

      $scope.model.resultList = response.results_list

      angular.forEach $scope.model.resultsList, (value, key) ->
        ApartmentDisplayService.formatApartmentDetails(value)

      angular.forEach $scope.model.resultsList, (value, key) ->
        ApartmentDataService.prepareApartmentData(value)

      debugger
      $scope.$broadcast('map:location:searched', address: $scope.model.config.address)
      $scope.$broadcast("map:data:retrieved", $scope.model.config.geo_boundary_points)


    $scope.model.viewApartments = ->
      Restangular.one('search', $state.params.searchId).all('results').getList($scope.model.config).then (response) ->
        $scope.model.apartmentList = response


        $scope.$broadcast("map:markers:retrieved", $scope.model.apartmentList)

    $scope.addApartment = ($event, apartment)->
      #don't show the popup
      $event.stopPropagation()

      Restangular.one('search', $state.params.searchId).all('apartments').post(apartment).then (->
        $scope.model.apartmentList = $scope.model.apartmentList.filter (apartmentToKeep) ->
          apartmentToKeep isnt apartment

        $scope.$broadcast("map:markers:removed", apartment)
      ), ->
        alert ('error adding apartment')

'use strict'

angular.module('admin.controllers')
.controller 'AdminAddApartmentsCtrl', ($scope, $state, Restangular,ApartmentDisplayService,ApartmentDataService) ->
    $scope.model = {}
    $scope.settings =
      searching: false

    Restangular.one('search', $state.params.searchId).one('add_apartments_config').get().then (response) ->
      $scope.model.config = response.originalElement
      $scope.$broadcast('map:location:searched', address: $scope.model.config.address)
      $scope.$broadcast("map:data:retrieved", $scope.model.config.geo_boundary_points)
      if response.geo_boundary_points?
        $scope.model.searchAddApartments()

    $scope.model.searchAddApartments = ->
      $scope.settings.searching = true
      Restangular.one('search', $state.params.searchId).all('apartments').getList($scope.model.config).then (response) ->
        $scope.settings.searching = false
        $scope.model.apartmentList = response
        angular.forEach $scope.model.apartmentList, (value, key) -> ApartmentDataService.prepareApartmentData(value)
        angular.forEach $scope.model.apartmentList, (value, key) -> ApartmentDisplayService.formatApartmentDetails(value)

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


    #todo this should by dry'd up because it's copied from the wizard-location-controller
    $scope.addDesiredHomeArea = ($event, $params) ->
      #first get a list of boundary paths
      #any given boundary path can have several points and each point is a lat/lng
      polygon = $params[0]
      $scope.polygonList ||= []
      $scope.polygonList.push polygon
      $scope.persistGeoBoundary()

    $scope.removeDesiredHomeArea = ($event, $params) ->
      polygonToRemove = $params[0]

      $scope.polygonList = $scope.polygonList.filter (polygon) ->
        polygon isnt polygonToRemove

      $scope.persistGeoBoundary()

    $scope.persistGeoBoundary = ->
      boundList = ([point.lat(), point.lng()] for point in path.getPath().getArray() for path in $scope.polygonList)

      boundHash = new ->
        @[i] = b for b, i in boundList
        this

      alert boundHash

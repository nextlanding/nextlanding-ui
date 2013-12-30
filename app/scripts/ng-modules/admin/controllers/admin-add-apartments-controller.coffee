'use strict'

angular.module('admin.controllers')
.controller 'AdminAddApartmentsCtrl', ($scope, $state, Restangular, ApartmentDisplayService, ApartmentDataService) ->
    $scope.model = {}
    $scope.settings =
      searching: false

    Restangular.one('search', $state.params.searchId).one('add_apartments_config').get().then (response) ->
      $scope.model.config = response.originalElement
      $scope.$broadcast('map:location:searched', address: $scope.model.config.address)
      $scope.$broadcast("map:data:retrieved", $scope.model.config.geo_boundary_points)
      $scope.model.searchAddApartments()

    $scope.model.searchAddApartments = ->
      if $scope.model.config.geo_boundary_points?
        $scope.settings.searching = true
        Restangular.one('search',
          $state.params.searchId).all('apartments').getList($scope.model.config).then (response) ->
            $scope.settings.searching = false
            $scope.model.apartmentList = response
            angular.forEach $scope.model.apartmentList, (value, key) ->
              ApartmentDataService.prepareApartmentData(value)
            angular.forEach $scope.model.apartmentList, (value, key) ->
              ApartmentDisplayService.formatApartmentDetails(value)

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
      polygon = $params[0].polygon
      $scope.polygonList ||= []
      $scope.polygonList.push polygon
      $scope.persistGeoBoundary($params[0].newlyCreated)

    $scope.removeDesiredHomeArea = ($event, $params) ->
      polygonToRemove = $params[0]

      $scope.polygonList = $scope.polygonList.filter (polygon) ->
        polygon isnt polygonToRemove

      $scope.persistGeoBoundary(true)

    $scope.persistGeoBoundary = (persistChanges) ->
      boundList = ([point.lat(), point.lng()] for point in path.getPath().getArray() for path in $scope.polygonList)

      boundHash = new ->
        @[i] = b for b, i in boundList
        this

      if persistChanges
        Restangular.one('search', $state.params.searchId).all('geo').post(geo_boundary_points:boundHash).then ->
          $scope.model.config.geo_boundary_points = boundHash

    $scope.model.addAllApartments = ->
      $scope.settings.searching = true
      Restangular.one('search', $state.params.searchId).all('add_available').post($scope.model.config).then ->
        $scope.settings.searching = false
        $scope.model.apartmentList = []

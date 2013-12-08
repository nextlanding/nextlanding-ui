'use strict'

angular.module('admin.controllers')
.controller 'AdminAddApartmentsCtrl', ($scope, $state, Restangular,ApartmentDisplayService,ApartmentDataService) ->
    $scope.model = {}
    $scope.settings =
      searching: false

    Restangular.one('search', $state.params.searchId).one('add_apartments_config').get().then (response) ->
      $scope.model.config = response
      $scope.model.searchAddApartments()
      $scope.$broadcast('map:location:searched', address: $scope.model.config.address)
      $scope.$broadcast("map:data:retrieved", $scope.model.config.geo_boundary_points)


    $scope.model.searchAddApartments = ->
      $scope.settings.searching = true
      Restangular.one('search', $state.params.searchId).all('apartments').getList($scope.model.config).then (response) ->
        $scope.settings.searching = false
        $scope.model.apartmentList = response
        angular.forEach $scope.model.apartmentList, (value, key) -> ApartmentDisplayService.formatApartmentDetails(value)
        angular.forEach $scope.model.apartmentList, (value, key) -> ApartmentDataService.prepareApartmentData(value)

        $scope.$broadcast("map:markers:retrieved", $scope.model.apartmentList)

    $scope.addApartment = ($event, apartment)->
      #don't show the popup
      $event.stopPropagation()

      $scope.model.apartmentList = $scope.model.apartmentList.filter (apartmentToKeep) ->
        apartmentToKeep isnt apartment

      $scope.$broadcast("map:markers:removed", apartment)

      alert apartment

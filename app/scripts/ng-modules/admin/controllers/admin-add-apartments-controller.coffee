'use strict'

angular.module('admin.controllers')
.controller 'AdminAddApartmentsCtrl', ($scope, $state, Restangular) ->
    $scope.model = {}
    $scope.settings =
      searching: false

    Restangular.one('search', $state.params.searchId).one('add_apartments_config').get().then (response) ->
      $scope.model.config = response
      $scope.model.searchAddApartments()

    $scope.model.searchAddApartments = ->
      $scope.settings.searching = true
      Restangular.one('search', $state.params.searchId).all('apartments').getList($scope.model.config).then (response) ->
        $scope.settings.searching = false

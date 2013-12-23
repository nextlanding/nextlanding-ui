'use strict'

### Controllers ###

angular.module('apartment.controllers')
  .controller 'ApartmentResultPopupCtrl', ($scope, $state, $modalInstance, apartment) ->
    $state.current.data.modal ||= true
    $scope.model = apartment
    $scope.close = ->
      $state.current.data.modal = false
      $modalInstance.close()

    $scope.sendAddApartment = ($event, apartment) ->
      $scope.close()
      $scope.addApartment($event, apartment)

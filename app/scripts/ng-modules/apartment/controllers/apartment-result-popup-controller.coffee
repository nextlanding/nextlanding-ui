'use strict'

### Controllers ###

angular.module('result.controllers')
  .controller 'ApartmentResultPopupCtrl', ($scope, $modalInstance, apartment) ->
    $scope.model = apartment
    $scope.close = ->
      $modalInstance.close()

    $scope.sendAddApartment = ($event, apartment) ->
      $scope.close()
      $scope.addApartment($event, apartment)

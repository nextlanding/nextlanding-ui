'use strict'

### Controllers ###

angular.module('result.controllers')
  .controller 'ApartmentResultPopupCtrl', ($scope, $modalInstance, apartment) ->
    $scope.close = ->
      $modalInstance.close()

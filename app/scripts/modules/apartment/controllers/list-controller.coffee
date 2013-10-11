'use strict'

### Controllers ###

angular.module('apartment.controllers')
  .controller('AptListCtrl', ($scope) ->
    $scope.apartments = [
      address: "123 Fake Street"
      bedroom_count: 2
      bathroom_count: 1.5
      price: 1850
    ,
      address: "W 84 and Broadway"
      bedroom_count: 2
      bathroom_count: 1.5
      price: 1850
    ]
  )

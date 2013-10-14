'use strict'

angular.module('googleMaps.controllers')
.controller "MapCtrl", ($scope) ->
    $scope.mapOptions =
      center: new google.maps.LatLng(40.714224, -73.961452)
      mapTypeId: google.maps.MapTypeId.ROADMAP,
      panControl: false,
      zoom: 12
    $scope.addDesiredHomeArea = ($event, $params) ->
      boundHash = (
        {
        i: [point.lat(), point.lng()]
        } for point,i in path.getArray() for path in $event.getPaths().getArray())
      debugger
      console.log(boundHash)

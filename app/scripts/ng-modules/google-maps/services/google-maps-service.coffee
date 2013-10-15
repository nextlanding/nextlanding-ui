'use strict'

angular.module('googleMaps.services')
.factory "googleMapsService", ->
    getBoundsFromPolygons: (polygons...) -> #http://stackoverflow.com/a/6339384/173957
      bounds = new google.maps.LatLngBounds()
      bounds.extend path for path in polygon for polygon in polygons

      bounds

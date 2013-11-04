'use strict'

angular.module('googleMaps.services')
.factory "GoogleMapsService", (GoogleMaps) ->
    getBoundsFromPolygons: (polygons...) -> #http://stackoverflow.com/a/6339384/173957
      bounds = new GoogleMaps.LatLngBounds()
      bounds.extend path for path in polygon.getPath().getArray() for polygon in polygons

      bounds

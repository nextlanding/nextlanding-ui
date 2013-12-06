'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsReadOnlyMap", (GoogleMaps, GoogleMapsService) ->
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      #ui-map.js uses the same attr so we can avoid isolated scope
      map = scope[attrs.uiMap]

      polygonOptions =
        fillColor: "#0076BF"
        fillOpacity: 0.3
        strokeColor: "#0076BF"
        strokeOpacity: 0.5
        strokeWeight: 2
        clickable: false,
        zIndex: 1

      offDataRetrieved =
        scope.$on "map:data:retrieved", (event, args)->
          polygonList = []

          angular.forEach args, (value, key) ->
            paths = (new GoogleMaps.LatLng(p[0], p[1]) for p in value)
            newPolygon = new GoogleMaps.Polygon angular.extend
              paths: paths
              map: map,
              polygonOptions

            polygonList.push newPolygon

          # this directive will not force the map to actually "re-paint" itself with the boundaries
          # that's the responsiblity of the RepaintableMapDirective. The google map has some conditions in which it must
          # be a visible DOM element to correctly resize itself.
          scope.bounds = GoogleMapsService.getBoundsFromPolygons(polygonList...)

          #we only want to be notified the first time we've gotten map data
          offDataRetrieved()

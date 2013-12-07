'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsReadOnlyMap", (GoogleMaps, GoogleMapsService, $templateCache, $compile) ->
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      map = scope[attrs.uiMap]
      infoBoxTemplate = $compile($templateCache.get(attrs.templateUrl))

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

      markerList = []
      tooltip = null
      offMarkersRetrieved =
        scope.$on "map:markers:retrieved", (event, args)->
          marker.setMap null for marker in markerList

          markerList = []

          angular.forEach args, (value, key) ->
            marker = new GoogleMaps.Marker
              position: new google.maps.LatLng(value.lat, value.lng)
              map: map
              dataItem: value

            markerList.push marker

            content = infoBoxTemplate(marker.dataItem)
            debugger

            #display the 'remove' label when we hover over the polygon
            GoogleMaps.event.addListener marker, "mouseover", (mouseOverEvent) ->
              tooltip = new InfoBox
                alignBottom: true
                closeBoxURL: ''
                content: content[0]
                isHidden: false
                pixelOffset: new google.maps.Size(-120, -34)

              tooltip.open map, this
            GoogleMaps.event.addListener marker, "mouseout", (event) ->
              tooltip.setVisible false

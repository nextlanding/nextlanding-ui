'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsDrawabbleMap", (GoogleMaps, GoogleMapsService) ->
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
        draggable: true
        zIndex: 1
        editable: true

      drawingManager = new GoogleMaps.drawing.DrawingManager
        drawingMode: GoogleMaps.drawing.OverlayType.POLYGON
        drawingControl: true
        drawingControlOptions:
          position: GoogleMaps.ControlPosition.TOP_CENTER
          drawingModes: [GoogleMaps.drawing.OverlayType.POLYGON]
        polygonOptions: polygonOptions

      drawingManager.setMap map

      #display a marker to remove polygon
      #http://stackoverflow.com/a/10723555/173957
      marker = new MarkerWithLabel
        position: new google.maps.LatLng(0, 0)
        draggable: false
        raiseOnDrag: false
        map: map
        labelContent: "Click anywhere on the blue drawing to remove it"
        labelAnchor: new google.maps.Point(0, 40)
        labelClass: "map-marker-label" # the CSS class for the label
        labelStyle:
          opacity: 1.0
        icon: "http://placehold.it/1x1"
        visible: false

      eventName = 'polygoncomplete'
      GoogleMaps.event.addListener drawingManager, eventName, (newPolygon) ->

        #remove the drawing option
        drawingManager.setDrawingMode null

        addPolygonEvents newPolygon

        elm.triggerHandler "map-" + eventName, newPolygon

        #We create an $apply if it isn't happening. we need better support for this
        #We don't want to use timeout because tons of these events fire at once,
        #and we only need one $apply
        scope.$apply()  unless scope.$$phase

      addPolygonEvents = (newPolygon)->
        #when they click the polygon, it'll be deleted
        GoogleMaps.event.addListener newPolygon, 'click', ->
          newPolygon.setMap null
          elm.triggerHandler "map-" + 'click', newPolygon

        #display the 'remove' label when we hover over the polygon
        GoogleMaps.event.addListener newPolygon, "mouseover", (mouseOverEvent) ->
          bounds = GoogleMapsService.getBoundsFromPolygons(newPolygon)

          marker.setPosition new google.maps.LatLng(bounds.getNorthEast().lat(), bounds.getCenter().lng())
          marker.setVisible true
        GoogleMaps.event.addListener newPolygon, "mouseout", (event) ->
          marker.setVisible false

      offDataRetrieved =
        scope.$on "map:data:retrieved", (event, args)->
          polygonList = []

          angular.forEach args, (value, key) ->
            paths = (new GoogleMaps.LatLng(p[0], p[1]) for p in value)
            newPolygon = new GoogleMaps.Polygon angular.extend
              paths: paths
              map: map,
              polygonOptions

            addPolygonEvents(newPolygon)

            polygonList.push newPolygon

          # this directive will not force the map to actually "re-paint" itself with the boundaries
          # that's the responsiblity of the RepaintableMapDirective. The google map has some conditions in which it must
          # be a visible DOM element to correctly resize itself.
          scope.bounds = GoogleMapsService.getBoundsFromPolygons(polygonList...)

          #remove the drawing option
          drawingManager.setDrawingMode null

          #we only want to be notified the first time we've gotten map data
          offDataRetrieved()

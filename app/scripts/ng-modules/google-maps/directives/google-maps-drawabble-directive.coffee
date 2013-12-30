'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsDrawabbleMap", (GoogleMaps, GoogleMapsService, $templateCache, $compile, Lodash) ->
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      #ui-map.js uses the same attr so we can avoid isolated scope
      map = scope[attrs.uiMap]
      infoBoxTemplate = $compile($templateCache.get(attrs.templateUrl))

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

      #display a remove_label to remove polygon
      #http://stackoverflow.com/a/10723555/173957
      remove_label = new MarkerWithLabel
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

        addPolygonEvents newPolygon, true

      addPolygonEvents = (newPolygon, newlyCreated)->
        #when they click the polygon, it'll be deleted
        GoogleMaps.event.addListener newPolygon, 'click', ->
          newPolygon.setMap null
          elm.triggerHandler "map-" + 'click', newPolygon

        #display the 'remove' label when we hover over the polygon
        GoogleMaps.event.addListener newPolygon, "mouseover", (mouseOverEvent) ->
          bounds = GoogleMapsService.getBoundsFromPolygons(newPolygon)

          remove_label.setPosition new google.maps.LatLng(bounds.getNorthEast().lat(), bounds.getCenter().lng())
          remove_label.setVisible true
        GoogleMaps.event.addListener newPolygon, "mouseout", (event) ->
          remove_label.setVisible false

        elm.triggerHandler "map-" + eventName, polygon:newPolygon, newlyCreated:newlyCreated

        #We create an $apply if it isn't happening. we need better support for this
        #We don't want to use timeout because tons of these events fire at once,
        #and we only need one $apply
        scope.$apply()  unless scope.$$phase

      offDataRetrieved =
        scope.$on "map:data:retrieved", (event, args)->
          polygonList = []

          angular.forEach args, (value, key) ->
            paths = (new GoogleMaps.LatLng(p[0], p[1]) for p in value)
            newPolygon = new GoogleMaps.Polygon angular.extend
              paths: paths
              map: map,
              polygonOptions

            addPolygonEvents newPolygon, false

            polygonList.push newPolygon

          # this directive will not force the map to actually "re-paint" itself with the boundaries
          # that's the responsiblity of the RepaintableMapDirective. The google map has some conditions in which it must
          # be a visible DOM element to correctly resize itself.
          scope.bounds = GoogleMapsService.getBoundsFromPolygons(polygonList...)

          #remove the drawing option
          drawingManager.setDrawingMode null

          #we only want to be notified the first time we've gotten map data
          offDataRetrieved()

      markerList = []
      tooltip = null

      scope.$on "map:markers:retrieved", (event, args)->
        marker.setMap null for marker in markerList

        markerList = []

        angular.forEach args, (value, key) ->
          marker = new GoogleMaps.Marker
            position: new google.maps.LatLng(value.lat, value.lng)
            map: map
            dataItem: value

          markerList.push marker

          #display the 'remove' label when we hover over the polygon
          GoogleMaps.event.addListener marker, "mouseover", (mouseOverEvent) ->
            highlightItem this
          GoogleMaps.event.addListener marker, "mouseout", (event) ->
            unhighlightItem this
          GoogleMaps.event.addListener marker, "click", (event) ->
            scope.$emit("map:markers:displayhighlight", this.dataItem)

      scope.$on "map:markers:highlight", (event, args)->
        marker = Lodash.find(markerList, { 'dataItem': args });
        highlightItem(marker)

      scope.$on "map:markers:removed", (event, args)->
        marker = Lodash.find(markerList, { 'dataItem': args });
        marker.setMap null

      scope.$on "map:markers:unhighlight", (event, args)->
        unhighlightItem()

      highlightItem = (item) ->
        tempScope = scope.$new()
        angular.extend(tempScope, item.dataItem)
        content = infoBoxTemplate(tempScope)[0]

        tooltip = new InfoBox
          alignBottom: true
          closeBoxURL: ''
          content: content
          isHidden: false
          pixelOffset: new google.maps.Size(-120, -34)

        tooltip.open map, item

      unhighlightItem = ->
        tooltip.setVisible false

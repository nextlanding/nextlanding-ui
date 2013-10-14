'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsDrawabbleMap", ->
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      map = scope[attrs.uiMap]
      window.map = map
      drawingManager = new google.maps.drawing.DrawingManager(
        drawingMode: google.maps.drawing.OverlayType.POLYGON
        drawingControl: true
        drawingControlOptions:
          position: google.maps.ControlPosition.TOP_CENTER
          drawingModes: [google.maps.drawing.OverlayType.POLYGON]

        polygonOptions:
          fillColor: "#0076BF"
          fillOpacity: 0.3
          strokeColor: "#0076BF"
          strokeOpacity: 0.5
          strokeWeight: 2
          clickable: false
          zIndex: 1
          editable: true
      )

      drawingManager.setMap map

      #region events
      eventName = 'polygoncomplete'
      google.maps.event.addListener drawingManager, eventName, (event) ->
        elm.triggerHandler "map-" + eventName, event

        #We create an $apply if it isn't happening. we need better support for this
        #We don't want to use timeout because tons of these events fire at once,
        #and we only need one $apply
        scope.$apply()  unless scope.$$phase
      #endregion events

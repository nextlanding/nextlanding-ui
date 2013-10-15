'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsResizableMap", (googleMaps) ->
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      map = scope[attrs.uiMap]
      scope.$on "map:ui:shown", (event, args)->
        googleMaps.event.trigger(map, 'resize')
        map.fitBounds scope.bounds if scope.bounds

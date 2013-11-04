'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsRepaintableMap", ($timeout, GoogleMaps) ->
    # The google map has some conditions in which it must be a visible DOM element to correctly resize itself.
    # These conditions seem to require each component, like our own controllers, to know about its visibilty. Instead
    # of each module knowing when to repaint the map, this directive can be used to take care of painting/formatting..
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      #ui-map.js uses the same attr so we can avoid isolated scope
      map = scope[attrs.uiMap]
      scope.$on "map:ui:shown", (event, args)->
        $timeout ->
          #use a delay because most of the time, the resizing should occur immediately after an angular cycle
          #like when an ng-show has been set to the True condition
          GoogleMaps.event.trigger(map, 'resize')
          map.fitBounds scope.bounds if scope.bounds

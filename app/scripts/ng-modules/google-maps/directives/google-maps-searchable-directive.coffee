'use strict'

angular.module('googleMaps.directives')
.directive "googleMapsSearchableMap", (GoogleMaps) ->
    # The google map has some conditions in which it must be a visible DOM element to correctly resize itself.
    # These conditions seem to require each component, like our own controllers, to know about its visibilty. Instead
    # of each module knowing when to repaint the map, this directive can be used to take care of painting/formatting..
    restrict: "A"
    #doesn't work as E for unknown reason
    link: (scope, elm, attrs) ->
      #ui-map.js uses the same attr so we can avoid isolated scope
      map = scope[attrs.uiMap]
      geocoder = new GoogleMaps.Geocoder()

      scope.$on "map:location:searched", (event, args)->
        address = args.address
        if address.lat? and address.lng?
          map.setCenter new GoogleMaps.LatLng(address.lat, address.lng)
        else
          geocoder.geocode
            address: address,
            (results, status) ->
              if status is google.maps.GeocoderStatus.OK
                map.setCenter results[0].geometry.location
              else
                alert "Geocode was not successful for the following reason: " + status

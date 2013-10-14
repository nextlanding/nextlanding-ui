'use strict'

angular.module('googleMaps.controllers')
.controller "SearchMapCtrl", ($scope) ->
    $scope.$watch('currentStep', (newVal) ->
      $scope.$broadcast("map:ui:shown") if newVal is 'geographyStep'
    )

    $scope.$watch('search', (search) ->
      $scope.$broadcast("map:data:retrieved", search.search_attrs.geo_boundary_points) if search.search_attrs?.geo_boundary_points?
    )

    $scope.mapOptions =
      mapTypeId: google.maps.MapTypeId.ROADMAP
      panControl: false
      center: new google.maps.LatLng(40.714224, -73.961452)
      zoom: 12

    $scope.addDesiredHomeArea = ($event, $params) ->
      #first get a list of boundary paths
      #any given boundary path can have sever points and each point is a lat/lng
      boundList = ([point.lat(), point.lng()] for point,i in path.getArray() for path in $event.getPaths().getArray())

      #the api expects a hash of boundary paths
      # {
      #   0:[ #this represents one colored area - or a region they desire to live
      #       [123,123],
      #       [542,5234]
      #     ]
      # }
      boundHash = new ->
        @[i] = b for b, i in boundList
        this

      $scope.search.search_attrs.geo_boundary_points = boundHash

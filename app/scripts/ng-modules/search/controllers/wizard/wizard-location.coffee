'use strict'

angular.module('search.controllers')
.controller "SearchWizardLocationCtrl", ($scope,googleMaps) ->
    $scope.$watch('currentStep', (newVal) ->
      $scope.$broadcast("map:ui:shown") if newVal is 'locationStep'
    )

    $scope.$watch('search', (search) ->
      $scope.$broadcast("map:data:retrieved", search.search_attrs.geo_boundary_points) if search.search_attrs?.geo_boundary_points?
    )

    # FYI - I don't really know why the UI guys decided to have the controller be responsible for the map settings
    # as this seems like more of a directive concern...
    $scope.mapOptions =
      mapTypeId: googleMaps.MapTypeId.ROADMAP
      panControl: false
      center: new googleMaps.LatLng(40.714224, -73.961452)
      zoom: 12

    $scope.addDesiredHomeArea = ($event, $params) ->
      #first get a list of boundary paths
      #any given boundary path can have several points and each point is a lat/lng
      $scope.pathList ||= []
      $scope.pathList.push $event.getPath().getArray()
      boundList = ([point.lat(), point.lng()] for point in path for path in $scope.pathList)

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

    $scope.geoLookup = ->
      if $scope.locationStepForm.$valid
        alert $scope.search.search_attrs.specified_location

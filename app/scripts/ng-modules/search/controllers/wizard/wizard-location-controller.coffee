'use strict'

angular.module('search.controllers')
.controller "SearchWizardLocationCtrl", ($scope, GoogleMaps, SearchWizardModel) ->
    $scope.model = SearchWizardModel
#    $scope.$watch('model.data', (search) ->
#      $scope.$broadcast("map:data:retrieved",
#        search.search_attrs.geo_boundary_points) if search.search_attrs?.geo_boundary_points?)
    $scope.$on "currentStep:changed:locationStep", ->
      $scope.currentStep.form = $scope.locationStepForm

    # FYI - I don't really know why the UI guys decided to have the controller be responsible for the map settings
    # as this seems like more of a directive concern...
    $scope.mapOptions =
      mapTypeId: GoogleMaps.MapTypeId.ROADMAP
      panControl: false
      center: new GoogleMaps.LatLng(40.714224, -73.961452)
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

      $scope.model.search.search_attrs.geo_boundary_points = boundHash

    $scope.geoLookup = ($event)  ->
      #we want the enter event to not trigger a form submission - just do the map lookup - do not move onto the next step
      $event.preventDefault()

      #even tho the button is disabled, they still might hit enter
      if $scope.locationStepForm.$valid and $scope.locationStepForm.$dirty
        $scope.$broadcast('map:location:searched', address: $scope.model.search.search_attrs.specified_location)
        $scope.locationEntered = true
        $scope.locationStepForm.$setPristine()
        $scope.$broadcast("map:ui:shown")

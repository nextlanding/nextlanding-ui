'use strict'

### Controllers ###

angular.module('apartment.controllers')
.controller 'ApartmentResultListCtrl', ($scope, GoogleMaps, $modal) ->
    # FYI - I don't really know why the UI guys decided to have the controller be responsible for the map settings
    # as this seems like more of a directive concern...
    $scope.mapOptions =
      mapTypeId: GoogleMaps.MapTypeId.ROADMAP
      panControl: false
      center: new GoogleMaps.LatLng(40.714224, -73.961452)
      zoom: 12

    $scope.highlightApartment = (apartment) ->
      $scope.$broadcast("map:markers:highlight", apartment)
    $scope.unhighlightApartment = (apartment) ->
      $scope.$broadcast("map:markers:unhighlight", apartment)

    $scope.$on "map:markers:displayhighlight", (event, args)->
      $scope.displayApartment(args)

    $scope.displayApartment = (apartment) ->
      $modal.open
        templateUrl: "/_public/js/apartment/apartment-popup.html"
        controller: 'ApartmentResultPopupCtrl'
        scope: $scope
        resolve:
          apartment: ->
            apartment

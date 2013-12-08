'use strict'

### Controllers ###

angular.module('apartment.services')
.factory 'ApartmentDataService', ->

    prepareApartmentData: (apartment) ->
      apartment.listing_urls = if apartment.listing_urls then angular.fromJson apartment.listing_urls else []
      apartment.amenities = if apartment.amenities then angular.fromJson apartment.amenities else {}

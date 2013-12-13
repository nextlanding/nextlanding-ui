'use strict'

### Controllers ###

angular.module('apartment.services')
.factory 'ApartmentDataService', ->

    prepareApartmentData: (apartment) ->
      apartment.listing_urls = if apartment.listing_urls then angular.fromJson apartment.listing_urls else []
      apartment.amenities = if apartment.amenities then angular.fromJson apartment.amenities else {}
      apartment.sqfeet = if apartment.sqfeet then parseInt(apartment.sqfeet)
      apartment.bathroom_count = if apartment.bathroom_count then parseInt(apartment.bathroom_count)
      apartment.price = if apartment.price then parseInt(apartment.price)

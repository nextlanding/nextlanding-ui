'use strict'

### Controllers ###

angular.module('apartment.services')
.factory 'ApartmentDisplayService', ->

    formatApartmentDetails: (apartment) ->
      apartment.bedroom_count = if apartment.bedroom_count then apartment.bedroom_count + " br" else "Studio"
      apartment.bathroom_count += ' ba'
      apartment.sqfeet = if apartment.sqfeet then apartment.sqfeet + " sqft." else "-"
      apartment.broker_fee = if apartment.broker_fee then 'Fee' else 'No Fee'

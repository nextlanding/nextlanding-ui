'use strict'

### Filters ###

angular.module('main.filters')

.filter('interpolate',(version) ->
  (text) -> String(text).replace(/\%VERSION\%/mg, version)
)

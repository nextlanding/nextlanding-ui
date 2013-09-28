'use strict'

### Filters ###

angular.module('app.filters', [])

.filter('interpolate',(version) ->
  (text) -> String(text).replace(/\%VERSION\%/mg, version)
)

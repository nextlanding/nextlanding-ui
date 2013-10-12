'use strict'

angular.module('main.directives').directive('appVersion', (version) ->
  (scope, elm, attrs) -> elm.text(version)
)

'use strict'

window.onGoogleReady = ->
  angular.bootstrap document.getElementById "map", ["app.ui-map"]

angular.module 'app.ui-map', ['ui.map']

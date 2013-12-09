'use strict'

angular.module('analytics',[])
.factory "mixpanel", ->
    window.mixpanel
.factory "ga", ->
    window.ga
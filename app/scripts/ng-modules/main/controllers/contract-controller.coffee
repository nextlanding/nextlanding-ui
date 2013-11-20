'use strict'

angular.module('app.controllers')
.controller 'ContractCtrl', ($scope, $state) ->
    mixpanel.track('Experiment Brokerage Ad Analytics: Visited Contact Page')

'use strict'

angular.module('app.controllers')
.controller 'ContractCtrl', ($scope, $state) ->
    mixpanel.track('Experiment Listing Database: Visited Contact Page')

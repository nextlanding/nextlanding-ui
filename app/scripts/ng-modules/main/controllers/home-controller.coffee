'use strict'

angular.module('main.controllers')
.controller 'HomeCtrl', ($scope, $state) ->
  $scope.startSearch = ->
    $state.go('search')

'use strict'

angular.module('app.controllers')
.controller 'HomeCtrl', ($scope, $state, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.startSearch = ->
      $state.go 'search'

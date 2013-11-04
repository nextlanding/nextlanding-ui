'use strict'

angular.module('main.controllers')
.controller 'HomeCtrl', ($scope, $state, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.startSearch = ->
      $state.go('search')

'use strict'

angular.module('admin.controllers')
.controller 'AdminAddApartmentsCtrl', ($scope, $state, Restangular) ->
    $scope.model = {}

    Restangular.one('search', $state.params.searchId).one('add_apartments_config').get().then (response) ->
      $scope.model.config = response

    $scope.model.sendEmails = ->
      $scope.settings.emailsPending = true
      $scope.model.post().then (->
        alert ('Sent')
      ), ->
        $scope.settings.emailsPending = false
        alert ('Error')

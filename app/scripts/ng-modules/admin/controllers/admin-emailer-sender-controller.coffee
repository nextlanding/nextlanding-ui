'use strict'

angular.module('admin.controllers')
.controller 'AdminEmailerSenderCtrl', ($scope, $state, Restangular) ->
    $scope.settings =
      emailsPending: false

    Restangular.one('search', $state.params.searchId).one('emailer_sender').get().then (response) ->
      $scope.model = response

    $scope.settings.sendEmails = ->
      $scope.settings.emailsPending = true
      $scope.model.post().then (->
        alert ('Sent')
      ), ->
        $scope.settings.emailsPending = false
        alert ('Error')

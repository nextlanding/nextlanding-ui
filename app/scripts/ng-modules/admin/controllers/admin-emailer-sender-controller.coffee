'use strict'

angular.module('admin.controllers')
.controller 'AdminEmailerSenderCtrl', ($scope, $state, AdminEmailerSenderModel, Restangular) ->
    $scope.model =
      searchId: $state.params.searchId
    Restangular.one('emailer_sender', $scope.model.searchId).get().then (response) ->
      $scope.model.subject = response.subject
      $scope.model.body = response.body
      $scope.model.search_description = response.search_description

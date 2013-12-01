'use strict'

angular.module('admin.controllers')
.controller 'AdminEmailerSenderCtrl', ($scope, $state, AdminEmailerSenderModel, Restangular) ->
    $scope.model = searchId:$state.params.searchId

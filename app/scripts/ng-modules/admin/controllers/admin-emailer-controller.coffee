'use strict'

angular.module('admin.controllers')
.controller 'AdminEmailerCtrl', ($scope, $state, AdminEmailerSenderModel, Restangular) ->
    $scope.model = searchId:$state.params.searchId
    $





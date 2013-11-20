'use strict'

angular.module('app.controllers')
.controller 'HomeCtrl', ($scope, $state) ->
    $scope.model = {}

    $scope.startSearch = ->
      mixpanel.name_tag $scope.model.email 
      
      mixpanel.people.set
        $email: $scope.model.email
        $created: new Date()
        $last_login: new Date()
        $first_name: $scope.model.first_name
        $last_name: $scope.model.last_name
        $phone_number: $scope.model.phone_number

      mixpanel.track "$signup", User: data.user_id;

      mixpanel.track('Experiment Brokerage Ad Analytics: Signup')

      $state.go('search')

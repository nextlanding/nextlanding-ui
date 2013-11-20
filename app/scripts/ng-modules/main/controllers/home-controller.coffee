'use strict'

angular.module('app.controllers')
.controller 'HomeCtrl', ($scope, $state) ->
    $scope.model = {}
    mixpanel.track('Experiment Brokerage Ad Analytics: Visited Homepage')

    $scope.startSearch = ->
      mixpanel.name_tag $scope.model.emailAddress

      mixpanel.identify $scope.model.emailAddress

      mixpanel.people.set
        $email: $scope.model.emailAddress
        $created: new Date()
        $last_login: new Date()
        $first_name: $scope.model.firstName
        $last_name: $scope.model.lastName
        $phone_number: $scope.model.phoneNumber

      mixpanel.track "$signup", User: $scope.model.emailAddress

      mixpanel.track('Experiment Brokerage Ad Analytics: Signup')

      $state.go('contact')

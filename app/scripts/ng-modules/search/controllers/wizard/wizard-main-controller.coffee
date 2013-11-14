'use strict'

### Controllers ###

angular.module('search.controllers')
.controller 'SearchWizardMainCtrl', ($scope, SearchWizardModel) ->
    $scope.model = SearchWizardModel

    $scope.currentStep= {form:null}

    #    searchInitResource.get().then (search) ->
    #      if search?
    #        saveSearchToScope(search, $scope)

    $scope.proceed = -> $scope.model.proceed()
    $scope.retreat = -> $scope.model.retreat()
    $scope.isLastStep = -> $scope.model.isLastStep()

    $scope.isCurrentStep = (stepName)->
      $scope.model.getCurrentStep() == stepName

    saveSearchToScope = (search, scope)->
      search.search_attrs = angular.fromJson search.search_attrs
      scope.search = search

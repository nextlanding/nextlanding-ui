'use strict'

#http://docs.angularjs.org/guide/forms
#http://stackoverflow.com/questions/15219717/to-test-a-custom-validation-angular-directive

INTEGER_REGEXP = /^\-?\d*$/
FLOAT_REGEXP = /^\-?\d+((\.|\,)\d+)?$/

angular.module('app.directives')
.directive "integer", ->
    restrict: 'A'
    require: 'ngModel'
    link: (scope, elem, attrs, ngModelCtrl) ->
      ngModelCtrl.$parsers.unshift (viewValue) ->
        if INTEGER_REGEXP.test(viewValue)
          # it is valid
          ngModelCtrl.$setValidity "integer", true
          viewValue
        else
          # it is invalid, return undefined (no model update)
          ngModelCtrl.$setValidity "integer", false
          undefined

angular.module('app.directives')
.directive "float", ->
    restrict: 'A'
    require: 'ngModel'
    link: (scope, elem, attrs, ngModelCtrl) ->
      ngModelCtrl.$parsers.unshift (viewValue) ->
        if FLOAT_REGEXP.test(viewValue)
          ngModelCtrl.$setValidity "float", true
          parseFloat viewValue.replace(",", ".")
        else
          ngModelCtrl.$setValidity "float", false
          undefined

'use strict'

angular.module('momentjs',[])
.factory "momentjs", ->
    window.moment
.filter "fromNow",(momentjs) ->
    #http://stackoverflow.com/questions/14774486/use-jquery-timeago-or-momentjs-and-angularjs-together
    (date) ->
      momentjs(date).fromNow()

'use strict'

angular.module('admin.controllers')
.controller 'AdminCreateCrawlCtrl', ($scope, $state, Restangular) ->
    $scope.settings =
      crawlerPending: false

    $scope.model =
      crawl_urls: null

    $scope.settings.crawlUrls = ->
      $scope.settings.crawlerPending = true

      crawl_urls_split = $scope.model.crawl_urls.split ('\n')

      Restangular.all('crawl').post(crawl_urls:crawl_urls_split).then (->
        alert ('Sent')
      ), ->
        $scope.settings.crawlerPending = false
        alert ('Error')

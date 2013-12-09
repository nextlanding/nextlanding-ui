'use strict'

angular.module('analytics', [])
.factory "Analytics", ->
    _mixpanel = window.mixpanel
    _ga = window.ga

    trackLogin = (loginProps) ->
      _mixpanel.people.set
        "$email": loginProps.emailAddress
        "$last_login": new Date()
        "$first_name": loginProps.firstName,
        "$last_name": loginProps.lastName,
        "$username": loginProps.username

      _mixpanel.people.set_once
        "$created": loginProps.createdDate or new Date()

    trackPageView: (pageName, url) ->
      #trackPageView doesn't actually persist events - only used for the stream tab
      #https://mixpanel.com/docs/integration-libraries/javascript-full-api#track_pageview
      _mixpanel.track_pageview url

      #this will actually capture an event
      _mixpanel.track "Page Viewed",
        "Page Name": pageName,
        "URL": url

      _ga 'send', 'pageview',
        page: url
        title: pageName

    init: (trackingIds) ->
      mixpanelTrackingId = trackingIds['mixpanel']
      googleTrackingId = trackingIds['googleAnalytics']

      _mixpanel.init mixpanelTrackingId

      _ga 'create', googleTrackingId

    trackEvent: (eventName, props) ->
      #only track events w/ mixpanel
      _mixpanel.track eventName, props

    trackCharge: (amount) ->
      _mixpanel.people.track_charge amount

    nameTag: (nameTag) ->
      _mixpanel.name_tag nameTag

    userSignup: (userProps) ->
      _mixpanel.alias userProps.emailAddress

      #ensure that nameTag is called before the following events to show proper info in the stream
      trackLogin userProps
      mixpanel.track "$signup", User: userProps.emailAddress

    trackLogin: trackLogin

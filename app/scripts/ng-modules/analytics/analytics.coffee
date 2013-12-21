'use strict'

angular.module('analytics', [])
.factory "Analytics", ->
    trackLogin = (loginProps) ->
      window.mixpanel.people.set
        "$email": loginProps.emailAddress
        "$last_login": new Date()
        "$first_name": loginProps.firstName,
        "$last_name": loginProps.lastName,
        "$username": loginProps.username

      window.mixpanel.people.set_once
        "$created": loginProps.createdDate or new Date()

    trackPageView: (pageName, url) ->
      #trackPageView doesn't actually persist events - only used for the stream tab
      #https://mixpanel.com/docs/integration-libraries/javascript-full-api#track_pageview
      window.mixpanel.track_pageview url

      #this will actually capture an event
      window.mixpanel.track "Page Viewed",
        "Page Name": pageName,
        "URL": url

      window.ga 'send', 'pageview',
        page: url
        title: pageName

    init: (trackingIds) ->
      mixpanelTrackingId = trackingIds['mixpanel']
      googleTrackingId = trackingIds['googleAnalytics']

      window.mixpanel.init mixpanelTrackingId

      window.ga 'create', googleTrackingId

    trackEvent: (eventName, props) ->
      #only track events w/ mixpanel
      window.mixpanel.track eventName, props

    trackCharge: (amount, product) ->
      window.mixpanel.people.track_charge amount
      mixpanel.people.increment("Purchase: #{product}")

    isSignedUp: ->
      window.mixpanel.cookie.props.mp_name_tag?

    userSignup: (userProps) ->
      window.mixpanel.name_tag userProps.emailAddress

      window.mixpanel.alias userProps.emailAddress

      #ensure that nameTag is called before the following events to show proper info in the stream
      trackLogin userProps
      mixpanel.track "$signup", User: userProps.emailAddress

    trackLogin: trackLogin

# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  initialize = ->

    if navigator.geolocation
      navigator.geolocation.getCurrentPosition ((userposition) ->
        console.log "position:"
        console.log userposition
        pos = new google.maps.LatLng(userposition.coords.latitude, userposition.coords.longitude)
        console.log "timestamp"
        console.log new Date(userposition.timestamp)

        console.log "setting mapOptions"
        mapOptions =
          zoom: 12,
          center: pos
          mapTypeId: google.maps.MapTypeId.ROADMAP

        console.log "creating Map"
        map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)

        marker = new google.maps.Marker
          position: pos
          map: map

        infowindow = new google.maps.InfoWindow
          map: map,
          position: pos,
          content: "Your current location as detected"

      ), ->
        handleNoGeolocation true
      , { maximumAge: 0, timeout: 5000 }

    else

      handleNoGeolocation false

  handleNoGeolocation = (errorflag) ->
    if errorFlag
      content = "Error: Geolocation service failed"
    else
      content = "Error: Browser geolocation support not available"

    options =
      map: map,
      position: new google.maps.LatLng(60, 105),
      content: content

    infowindow = new google.maps.InfoWindow options
    map.setCenter options.userposition

  google.maps.event.addDomListener window, "load", initialize()


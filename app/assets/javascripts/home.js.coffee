# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  initialize = ->

    # HTML5 Geolocation handler on page load

    if navigator.geolocation
      # Geolocation Success handler
      navigator.geolocation.getCurrentPosition ((userposition) ->
        pos = new google.maps.LatLng(userposition.coords.latitude, userposition.coords.longitude)

        setMap(pos)

        setMarker(pos)

        infowindow = new google.maps.InfoWindow
          map: map,
          position: pos,
          content: "Your current location as detected"

      ), ->
        # Geolocation Failure handler
        handleNoGeolocation(true)
      , { maximumAge: 0, timeout: 5000 }

    else
      # Geolocation Support Failure handler
      handleNoGeolocation(false)

  # HTML5 Geolocation service failure handler
  handleNoGeolocation = (errorFlag) ->
    if errorFlag
      # handler when service failed to detect location
      console.log "Error: Geolocation service failed"
      content = "Error: Geolocation service failed"
    else
      # handler when service is not available
      console.log "Error: Browser geolocation support not available"
      content = "Error: Browser geolocation support not available"

    provisionaryCenter = new google.maps.LatLng(14.5833, 121.0000)
    setMap(provisionaryCenter)
    setMarker(provisionaryCenter)

  # Map creator, map center required
  setMap = (mapCenter) ->
    # map config, add settings here
    mapOptions =
      zoom: 12,
      center: mapCenter,
      mapTypeId: google.maps.MapTypeId.ROADMAP

    window.map = new google.maps.Map(document.getElementById('map_canvas'), mapOptions)

  # Infowindow creator
  setInfowindow = (content) ->
    options =
      map: map,
      content: content
    window.infowindow = new google.maps.InfoWindow options

  # Marker creator, position required
  setMarker = (markerCenter) ->
    marker = new google.maps.Marker
      position: markerCenter
      map: map

  # map service boot
  google.maps.event.addDomListener window, "load", initialize()


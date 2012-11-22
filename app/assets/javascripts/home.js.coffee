# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$(document).ready ->

  initialize = ->

    # HTML5 Geolocation handler on page load

    if navigator.geolocation
      # Geolocation Success handler
      navigator.geolocation.getCurrentPosition ((userposition) ->
        console.log "Browser geolocation supported."
        pos = new google.maps.LatLng(userposition.coords.latitude, userposition.coords.longitude)
        console.log "Position data:"
        console.log userposition

        setMap(pos)
        setMarker(pos)
        window.infowindow = new google.maps.InfoWindow
          map: map
          position: pos
          content: "Your current location as detected <br /> Accuracy: " + userposition.coords.accuracy + " meters <br /> As of " + new Date(userposition.timestamp)

      ), ->
        # Geolocation Failure handler
        handleNoGeolocation(true)
      , { enableHighAccuracy: true, maximumAge: 10000 } # adjust maximumAge to amount of time the last position is valid

      navigator.geolocation.watchPosition ((userposition) ->
        pos = new google.maps.LatLng(userposition.coords.latitude, userposition.coords.longitude)
        console.log "Position data:" + userposition.coords.latitude + ", " + userposition.coords.longitude
        map.setCenter(pos)
        console.log marker
        setMarker(pos)
        infowindow.setContent "Current position:" + userposition.coords.latitude + ", " + userposition.coords.longitude
        infowindow.setPosition(pos)
      ), ->
        # Geolocation Failure handler
        handleNoGeolocation(true)
      , { enableHighAccuracy: true, maximumAge: 10000 } # adjust maximumAge to amount of time the last position is valid

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
      zoom: 17,
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
    window.marker = new google.maps.Marker
      position: markerCenter
      map: map

  # Geocode Location
  geoCode = (coords) ->
    geocoder = new google.maps.Geocoder()
    geocoder.geocode {'latLng': coords}, (results, status) ->
      if status == google.maps.GeocoderStatus.OK
        window.address = results[0].formatted_address
        console.log "Address: " + address

      else console.log "geocode failed. reason: " + status

  # map service boot
  google.maps.event.addDomListener window, "load", initialize()

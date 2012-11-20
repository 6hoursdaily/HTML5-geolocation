$(document).ready ->
  if Gmaps.map.userLocationFailure == false
    Gmaps.map.callback = ->
      Gmaps.map.createMarker
        Lat: Gmaps.map.userLocation.lat()
        Lng: Gmaps.map.userLocation.lng()
        rich_marker: null
  else
    alert "userLocationFailure occured"

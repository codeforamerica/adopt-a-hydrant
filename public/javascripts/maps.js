$(function() {
  var map;

  var latlng = new google.maps.LatLng(42.358431,-71.059773);
  var myOptions = {
    zoom: 15,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

})

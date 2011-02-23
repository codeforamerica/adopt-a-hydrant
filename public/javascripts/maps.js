$(function() {
  var map;
	currentFeature_or_Features = null;

	var roadStyle = {
		strokeColor: "#FFFF00",
		strokeWeight: 7,
		strokeOpacity: 0.75
	};

	var addressStyle = {
		icon: "images/marker-hydrant.png"
	};

	var parcelStyle = {
		strokeColor: "#FF7800",
		strokeOpacity: 1,
		strokeWeight: 2,
		fillColor: "#46461F",
		fillOpacity: 0.25
	};

  var latlng = new google.maps.LatLng(42.358431,-71.059773);
  var myOptions = {
    zoom: 14,
    center: latlng,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById("map_canvas"), myOptions);

	function getHydrants() {
	  $.ajax({
      url: "http://civicapi.couchone.com/boston_fire_hydrants/_design/geo/_spatiallist/geojson/points",
      dataType: 'jsonp',
      data: {
        "bbox":"-71.07326030731201,42.35568977315507,-71.04317665100098,42.37176642783948"
      },
      success: function(data){
        showFeature(data, addressStyle);
      }
    });
	}

	function clearMap(){
		if (!currentFeature_or_Features)
			return;
		if (currentFeature_or_Features.length){
			for (var i = 0; i < currentFeature_or_Features.length; i++){
				currentFeature_or_Features[i].setMap(null);
			}
		}else{
			currentFeature_or_Features.setMap(null);
		}
	}

	function showFeature(geojson, style){
		clearMap();
		currentFeature_or_Features = new GeoJSON(geojson, style || null);
		if (currentFeature_or_Features.type && currentFeature_or_Features.type == "Error"){
			document.getElementById("put_geojson_string_here").value = currentFeature_or_Features.message;
			return;
		}
		if (currentFeature_or_Features.length){
			for (var i = 0; i < currentFeature_or_Features.length; i++){
				currentFeature_or_Features[i].setMap(map);
			}
		}else{
			currentFeature_or_Features.setMap(map)
		}

		document.getElementById("put_geojson_string_here").value = JSON.stringify(geojson);
	}

	getHydrants();
})

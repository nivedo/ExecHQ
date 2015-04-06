var map;
var geocoder;

function codeAddress(element) {
    var address = element.attr('title');
    geocoder.geocode( { 'address': address}, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            map.setZoom(13);
            if ($('#gmap_latitude').length) { $('#gmap_latitude').val(results[0].geometry.location.k) }
            if ($('#gmap_longitude').length) { $('#gmap_longitude').val(results[0].geometry.location.D) }
            var marker = new google.maps.Marker({
                   map: map,
                   position: results[0].geometry.location
            });
        } else {
            alert("Geocode was not successful for the following reason: " + status);
        }
    });
}

function initialize() {
  geocoder = new google.maps.Geocoder();

  var mapOptions = {
    center: new google.maps.LatLng(41.90,-87.67),
    zoom: 3,
    mapTypeId: google.maps.MapTypeId.ROADMAP
  };
  map = new google.maps.Map(document.getElementById('map-canvas'),
    mapOptions);

  var map_input = /** @type {HTMLInputElement} */(document.getElementById('gmap_location'));
  var autocomplete = new google.maps.places.Autocomplete(map_input);

  autocomplete.bindTo('bounds', map);

  var infowindow = new google.maps.InfoWindow();
  var marker = new google.maps.Marker({
    map: map
  });

  var styles = [{"featureType":"water","stylers":[{"visibility":"on"},{"color":"#b5cbe4"}]},{"featureType":"landscape","stylers":[{"color":"#efefef"}]},{"featureType":"road.highway","elementType":"geometry","stylers":[{"color":"#83a5b0"}]},{"featureType":"road.arterial","elementType":"geometry","stylers":[{"color":"#bdcdd3"}]},{"featureType":"road.local","elementType":"geometry","stylers":[{"color":"#ffffff"}]},{"featureType":"poi.park","elementType":"geometry","stylers":[{"color":"#e3eed3"}]},{"featureType":"administrative","stylers":[{"visibility":"on"},{"lightness":33}]},{"featureType":"road"},{"featureType":"poi.park","elementType":"labels","stylers":[{"visibility":"on"},{"lightness":20}]},{},{"featureType":"road","stylers":[{"lightness":20}]}]
  map.setOptions({styles: styles});

  google.maps.event.addListener(autocomplete, 'place_changed', function() {
    infowindow.close();
    marker.setVisible(false);
    map_input.className = '';
    var place = autocomplete.getPlace();
    if (!place.geometry) {
      // Inform the user that the place was not found and return.
      map_input.className = 'notfound';
      return;
    }

    // If the place has a geometry, then present it on a map.
    if (place.geometry.viewport) {
      map.fitBounds(place.geometry.viewport);
    } else {
      map.setCenter(place.geometry.location);
      map.setZoom(13);  // Why 17? Because it looks good.
    }
    marker.setIcon(/** @type {google.maps.Icon} */({
      url: place.icon,
      size: new google.maps.Size(71, 71),
      origin: new google.maps.Point(0, 0),
      anchor: new google.maps.Point(17, 34),
      scaledSize: new google.maps.Size(35, 35)
    }));
    marker.setPosition(place.geometry.location);
    if ($('#gmap_latitude').length) { $('#gmap_latitude').val(place.geometry.location.k) }
    if ($('#gmap_longitude').length) { $('#gmap_longitude').val(place.geometry.location.D) }
    marker.setVisible(true);

    var address = '';
    if (place.address_components) {
      address = [
        (place.address_components[0] && place.address_components[0].short_name || ''),
        (place.address_components[1] && place.address_components[1].short_name || ''),
        (place.address_components[2] && place.address_components[2].short_name || '')
      ].join(' ');
    }

    infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address);
    infowindow.open(map, marker);
  });
}

//google.maps.event.addDomListener(window, 'load', initialize);

$(document).ready(function(){
  $map = $('#map-canvas');
  if($map.length > 0) {
    initialize();
  }
  if($map.attr('title') != undefined) {
    codeAddress($map);
  }
});

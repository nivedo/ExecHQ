$map = $('#map-canvas');
if($map.length > 0) {
  initialize();
}
if($map.attr('title') != undefined) {
  codeAddress($map);
}

if($map.length > 0) { 
  google.maps.event.trigger(map, 'resize'); // Force resize for second half
}
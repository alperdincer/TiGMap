var win = Ti.UI.currentWindow;

Ti.API.info("---> Step -3");
var GoogleMapsClass = require('GoogleMaps');
Ti.API.info("---> Step -2");
var GoogleMaps = new GoogleMapsClass({
	iOSKey: "AIzaSyDPMmKovvGI3vTCX2KwSthuK0jxBvHuMHM"
});
Ti.API.info("---> Step -1");
var mapView = GoogleMaps.initMap({
	latitude: 39.83,
	longitude: 32.79,
	zoom: 6,
	top: 40,
	left:20,
	right:20,
	bottom:100
});
Ti.API.info("---> Step 0");
Ti.API.info("---> Step 1");
win.add(mapView);


var marker1 = GoogleMaps.createMarker({
	latitude: 39.6782, 
	longitude: 32.7882,
	title:'Marker-1',
	subtitle: 'Marker-1 Açıklaması',
	image: 'img/gr_pin'
});
Ti.API.info("---> Step 2");

GoogleMaps.addMarker(marker1);

/*
Ti.API.info("---> Step 3");
var polyline1 = GoogleMaps.createPolyline({
	pathColor : "#00ff00",
	width: 5,
	title: "deneme-1",
	tappable: true,
	path : [[39.32992, 32.992929], [39.32828, 32.2939], [40.32992, 33.2772]]		
});
Ti.API.info("---> Step 4");
GoogleMaps.addPolyline(polyline1);
Ti.API.info("---> Step 5");
*/
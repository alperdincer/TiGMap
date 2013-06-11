// This is a test harness for your module
// You should do something interesting in this harness 
// to test out the module and to provide instructions 
// to users on how to use it by example.

var lastMarkerId = 0;
var markerCount = 0;

function randomFloatBetween(minValue,maxValue,precision){
    if(typeof(precision) == 'undefined'){
        precision = 2;
    }
    return parseFloat(Math.min(minValue + (Math.random() * (maxValue - minValue)),maxValue).toFixed(precision));
}

var mainWin = Ti.UI.createWindow({
	backgroundColor:'white'
});

var btnWindow = Ti.UI.createWindow({
	backgroundColor:'white'
});

var nav = Titanium.UI.iPhone.createNavigationGroup({
   window: btnWindow
});

// open a single window
var win = Ti.UI.createWindow({
	backgroundColor:'white',
	url: 'map.js'
});


var button = Ti.UI.createButton({
	title: 'Open Map'
});
button.addEventListener('click', function(){
	nav.open(win, {animated:true});
});

btnWindow.add(button);
mainWin.add(nav);
mainWin.open();

/*

var MekansalGMap = require('com.mekansal.gmapios');
Ti.API.info("module is => " + MekansalGMap);

MekansalGMap.setAPIKey(require('/apikey'));

//label.text = MekansalGMap.example();

Ti.API.info("module exampleProp is => " + MekansalGMap.exampleProp);
MekansalGMap.exampleProp = "This is a test value";

var mapView = MekansalGMap.createView({
	location: {
		latitude: 39.82, //35.681382,
		longitude: 32.78
	},
	zoom: 6
	//"width":200,
	//"height":200
});

var outerMapView = Titanium.UI.createView({
	top:5,
	left:5,
	right:5,
	height:330,
	borderWidth:1,
	borderRadius:10,
	opacity: 1.0,
	borderColor:'#222'
}); 

outerMapView.add(mapView);

win.add(outerMapView);


/*setTimeout(function() {
		mapView.setZoom(8);
		//mapView.setBearing(90);
		//mapView.setViewingAngle(30);
		setTimeout(function() {
			mapView.setZoom(2);
		}, 3000);
	}, 4000);
*/

/*
	var tileLayer = MekansalGMap.createTileLayer({
		name :'gmap',
		tileUrl : "http://tilesrv01.dsi.gov.tr/basemap/%d/%d/%d.png",
		isAdded : false,
		zindex : 100
	});
	
	var tileLayer2 = MekansalGMap.createTileLayer({
		name:'baraj',
		tileUrl : "http://tilesrv01.dsi.gov.tr/tiles/barajisih/%d/%d/%d.png",
		zindex : 20
	});
	
	mapView.addTileLayer(tileLayer);
	mapView.addTileLayer(tileLayer2);
	//tileLayer.isAdded = true;
	
	var anns = [];
	anns.push(MekansalGMap.createAnnotation({
		latitude: 39.681382,
		longitude: 32.766084,
		title: 'Tokyo',
		markerColor : '#ff00ff',
		snippet: 'hogehoge, hogehoge',
		isAdded: false
	}));
	anns.push(MekansalGMap.createAnnotation({
		latitude: 39.690921,
		longitude: 32.700258,
		title: 'Shinjuku',
		markerIcon : 'gr_pin',
		snippet: 'hogehoge, hogehoge',
		isAdded: false
	}));
	anns.push(MekansalGMap.createAnnotation({
		latitude: 39.658517,
		longitude: 32.701334,
		title: 'Shibuya',
		snippet: 'hogehoge, hogehoge',
		markerColor : '#0000ff',
		isAdded: false
	}));

	var buttonbar = Ti.UI.createButtonBar({
		labels:['Tokyo', 'Shinjuku', 'Shibuya'],
		backgroundColor:'#336699',
		style:Ti.UI.iPhone.SystemButtonStyle.BAR,
		bottom:0,
		height:25,
		width:200
	});

	win.add(buttonbar);
	buttonbar.addEventListener('click', function(e){
		var ann = anns[e.index];
		if (!ann.isAdded) {
			mapView.addAnnotation(ann);
		} else {
			mapView.removeAnnotation(ann);
		}
		ann.isAdded = !ann.isAdded;
	});
	
	
	var buttonbar2 = Ti.UI.createButtonBar({
		labels:['NORMAL', 'SATELLITE', 'TERRAIN', 'HYBRID', 'NONE'],
		backgroundColor:'#336699',
		style:Ti.UI.iPhone.SystemButtonStyle.BAR,
		bottom:50,
		height:25,
		width:300
	});


	var polyline1 = MekansalGMap.createPolyline({
		"pathColor" : "#00ff00",
		"width": 30,
		"title": "deneme-2",
		"tappable": true	
	});
	polyline1.createPath([[39.32992, 32.992929], [39.32828, 32.2939], [40.32992, 33.2772]]);

	var polygon1 = MekansalGMap.createPolygon({
		"pathColor" : "#00ff00",
		"width": 5,
		"fillColor": "#ff0000",
		"title": "deneme-1",
		"tappable": true
	});
	polygon1.createPath([[29.32992, 22.992929], [29.32828, 22.2939], [30.32992, 23.2772]]);

	//var polygon1 = MekansalGMap.createPoly({});
	
	//polygon1.addCoordinateToPath("#csd233", 2323, [[39.32992, 32.992929], [39.32828, 32.2939], [40.32992, 33.2772]]);
	/*
	polygon1.addCoordinateToPath({
		lat: 39.805312,
		lng: 32.709022
	});
	
	polygon1.addCoordinateToPath({
		lat: 39.220323,
		lng: 32.637274
	});
	polygon1.addCoordinateToPath({
		"lat": 39.10,
		"lng": 32.10
	}); */

/*	
	var button3 = Ti.UI.createButton({
		title:"Remove Tile",
		right:10,
		bottom: 80,
		height: 30,
		width : 90
	});
	
	button3.addEventListener("click", function(e) {
		mapView.removeTileLayer(tileLayer);	
		//Bu kısmı sonra düzenle!! BBOX
		//var bbox = mapView.showBBOX({});
		//var bbox = mapView.getBBOX({});
		//Ti.API.info(bbox);
		//Ti.API.info("JS BBOX : " + bbox.farLeftLat + "/" + bbox.farLeftLng + " -- " + bbox.farRightLat + "/" + bbox.farRightLng);
		//mapView.setGestures({scroll: true });
		mapView.setScrollGesture(true);
		mapView.addPolyline(polyline1);
		mapView.addPolygon(polygon1);
		mapView.setLocationButton(false);
		mapView.setCompassButton(false);
		
		
	});
	
	var button4 = Ti.UI.createButton({
		title:"Rem.Polyline",
		left:10,
		bottom: 80,
		height: 30,
		width : 90
	});
	
	button4.addEventListener("click", function(e) {
		Ti.API.info("remove polyline....");
		mapView.removePolyline(polyline1);
		mapView.removePolygon(polygon1);
		mapView.setLocationButton(true);
		mapView.setCompassButton(true);
		mapView.setMyLocation(true);
	});
	
	win.add(button4);	
	
	win.add(button3);
	win.add(buttonbar2);

	var scrollGest = false;
	var zoomGest = false;
	var tiltGest = false;
	var rotateGest = false;
	var locationStat = false;

	buttonbar2.addEventListener('click', function(e){
		if (e.index === 0) {
			mapView.setMapType(MekansalGMap.NORMAL_TYPE);
			mapView.setLocation({
				latitude: 41.9231123,
				longitude: 28.028847
			});
			if (scrollGest == false) {
				mapView.setScrollGesture(true);
				scrollGest = true;
			}
			else {
				mapView.setScrollGesture(false);
				scrollGest = false;
			}			
		}
		else if (e.index === 1) {
			mapView.setMapType(MekansalGMap.SATELLITE_TYPE);
			mapView.setZoom(13);
			if (zoomGest == false) {
				mapView.setZoomGesture(true);
				zoomGest = true;
			}
			else {
				mapView.setZoomGesture(false);
				zoomGest = false;
			}				
		}
		else if (e.index === 2) {
			mapView.setMapType(MekansalGMap.TERRAIN_TYPE);
			mapView.setBearing(62.882);
			if (tiltGest == false) {
				mapView.setTiltGesture(true);
				tiltGest = true;
			}
			else {
				mapView.setTiltGesture(false);
				tiltGest = false;
			}				
		}
		else if (e.index === 3) {
			mapView.setMapType(MekansalGMap.HYBRID_TYPE);
			mapView.setViewingAngle(45.22);
			if (rotateGest == false) {
				mapView.setRotateGesture(true);
				rotateGest = true;
			}
			else {
				mapView.setRotateGesture(false);
				rotateGest = false;
			}				
		}
		else if (e.index === 4) {
			mapView.setMapType(MekansalGMap.NOMAP_TYPE);
			if (locationStat == false) {
				mapView.setMyLocation(true);
				locationStat = true;
			}
			else {
				mapView.setMyLocation(false);
				locationStat = false;
			}						
		}		
	});	
	
mapView.addEventListener("changeCameraPosition", function(e) {
	var bbox = e.bbox;
	var target = e.target;
	Ti.API.info("===> MapCameraPositionChange :");
	Ti.API.info("Zoom, Bearing, angle : " + e.zoom + " / " + e.bearing + " / " + e.viewAngle);
	Ti.API.info("Target : " + target.latitude + " / " + target.longitude);
	Ti.API.info("BBOX : FarLeft (" + bbox.farLeftLat + "/" + bbox.farLeftLng + "), FarRight (" +
				 bbox.farRightLat + "/" + bbox.farRightLng + "), NearLeft : (" + 
				 bbox.nearLeftLat + "/" + bbox.nearLeftLng + "), NearRight : (" +
				 bbox.nearRightLat + "/" + bbox.nearRightLng + ")");
});	

mapView.addEventListener("click", function(e) {
	Ti.API.info("===> MapClick :");
	Ti.API.info("Target : " + e.latitude + " / " + e.longitude);
});

mapView.addEventListener("longpress", function(e) {
	Ti.API.info("===> MapLongPress :");
	Ti.API.info("Target : " + e.latitude + " / " + e.longitude);
});


anns[1].addEventListener('click', function(e) {
	var msg = 'marker-1 clicked';
	Ti.API.info(msg);
});

anns[1].addEventListener('infoWindowClick', function(e) {
	var msg = 'infoWindow-1 clicked';
	Ti.API.info(msg);
});

mapView.addEventListener("overlayClick", function(e) {
	Ti.API.info("===> Overlay Click :" + e.overlayTitle);
});

/*

		
// TODO: write your module tests here
var tigmap = require('jp.daisaru11.dev.tigmap');
tigmap.setAPIKey(require('/apikey'));

Ti.API.info("module is => " + tigmap);

var mapView = tigmap.createGMapView({
	location: {
		latitude: -23, //35.681382,
		longitude: -139.766084
	},
	zoom: 6
	//"width":200,
	//"height":200
});

outerMapView.add(mapView);

mapView.addEventListener('olay1',function(e){
  Ti.API.info("------>>> olay-1 fire edildi");
});	

mapView.addEventListener("mapOnClick", function(e) {
	Ti.API.info("===> MapOnClick : Lat : " + e.lat + " / Lng : " + e.lng);
});

mapView.addEventListener("mapOnClickHold", function(e) {
	Ti.API.info("===> mapOnClickHold : Lat : " + e.lat + " / Lng : " + e.lng);
});

mapView.addEventListener("mapCenterChanged", function(e) {
	Ti.API.info("===> mapCenterChanged : Lat : " + e.lat + " / Lng : " + e.lng + "-" + e.zoom + " - " + e.bearing + " - " + e.angle);
});

mapView.addEventListener("mapMarkerClick", function(e) {
	Ti.API.info("===> mapMarkerClick : Lat : " + e.lat + " / Lng : " + e.lng + "-" + e.title + " - " + e.subtitle);
	//Ti.API.info("===> marker user data : " + e.userdata.id + " / " + e.userdata.category);
	Ti.API.info("===> marker user data : " + JSON.stringify(e.userdata));
});

mapView.addEventListener("mapMarkerInfoClick", function(e) {
	Ti.API.info("===> mapMarkerInfoClick : Lat : " + e.lat + " / Lng : " + e.lng + "-" + e.title + " - " + e.subtitle);
	//Ti.API.info("===> marker user data : " + e.userdata.id + " / " + e.userdata.category);
	Ti.API.info("===> markerInfo user data : " + JSON.stringify(e.userdata));
});

mapView.addEventListener('mapStarted',function(e){
	Ti.API.info("------>>> mapStarted fire edildi");
	mapView.startMapping({});
});	

win.add(outerMapView);

	mapView.setLocation({
		latitude: 39.76,
		longitude: 32.80
	});
	mapView.setZoom(6);
	
	mapView.setMapping({
		cmd: "show",
		lat: 32.9999,
		lng: 39.9999	
	});

	/*	
	mapView.setMapping({
		cmd: "show2",
		lat: 32.9999,
		lng: 39.9999	
	});
	*/
	
/*
mapView.addMarker({
	latitude: 39.76,
	longitude: 32.80
});
*/
/*
var addButton = Titanium.UI.createButton({
	title: "Marker Ekle",
	bottom:5,
	left:5
});
addButton.addEventListener('click', function () {
	Ti.API.info("Marker eklenecek");

	var lat = randomFloatBetween(39, 40, 6);
	var lng = randomFloatBetween(32, 33, 6);
	//var title = randomFloatBetween(1, 100, 0);

	var markerOptions = {
		//lat: 39.76822321,
		//lng: 32.75567532,
		lat: lat,
		lng: lng,
		title: "hebele-" + markerCount,
		subtitle: "altyazı : işüğçöÜĞİŞÇÖıİ",
		//icon: "glow-marker",
		icon: "gr_pin",
		userdata : {
			"id" : "799292",
			"category" : "benzinci",
			"deneme" : "xyz",
			"hebele" : "9282" 		
		}	
	};	
	markerCount++;	
	//var jsonx = mapView.addMarker(markerOptions);
	//lastMarkerId = jsonx.markerId;
	//lastMarkerId = mapView.addMarker(markerOptions);
	lastMarkerId = mapView.addMarker(markerOptions);
	Ti.API.info("Son id : " + lastMarkerId);
	//lastMarkerId = mapView.regionMonitoringEnabled();
	//Ti.API.info("Last Marker Id : " + lastMarkerId);
});

var removeButton = Titanium.UI.createButton({
	title: "Marker Sil",
	bottom:5,
	right:5
});
removeButton.addEventListener('click', function () {
	Ti.API.info("Marker silinecek");
	mapView.removeMarker({ markerId : lastMarkerId });	
});

var clearButton = Titanium.UI.createButton({
	title: "Temizle", //236430
	bottom:5
});
clearButton.addEventListener('click', function () {
	Ti.API.info("hepsi silinecek");
	mapView.clearMap({});	
});

win.add(addButton);
win.add(removeButton);
win.add(clearButton);
*/

//win.open();

/*
setTimeout(function() {
	mapView.setLocation({
		latitude: 34.693738,
		longitude: 135.502165
	});
	mapView.setZoom(12);
}, 5000);
*/
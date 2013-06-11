/*
 * Developer : Alper Dinçer
 * Create Date : 05.06.2013
 * Update Date : 05.06.2013
 * Purpose : This is a class for multi platform Google Maps, iOS and Android
 * 
 */

// Class Main Definition
// params :  {
//		iOSKey : "YOUR_API_KEY"
// }
function GoogleMaps (params) 
{
	this.module = null;
	this.mapView = null;
	this.mapObj = null;
	this.platform = Ti.Platform.osname;
	this.mapTypes = {};
	
	var that = this;
	
	if ( that.platform == "android" )
	{
		that.module = require('ti.map');
		//Android Key'i tiapp.xml dosyasında tutulmaktadır.
		
		that.mapTypes = { //TODO : bu kısmı da Android'de test edelim.
			"normal" : that.module.NORMAL_TYPE,
			"satellite" : that.module.SATELLITE_TYPE,
			"terrain" : that.module.TERRAIN_TYPE,
			"hybrid" : that.module.HYBRID_TYPE
		}
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.module = require('com.mekansal.gmapios');
		that.module.setAPIKey(params.iOSKey);
		//that.module.setAPIKey("AIzaSyDPMmKovvGI3vTCX2KwSthuK0jxBvHuMHM");
		
		that.mapTypes = {
			"normal" : that.module.NORMAL_TYPE,
			"satellite" : that.module.SATELLITE_TYPE,
			"terrain" : that.module.TERRAIN_TYPE,
			"hybrid" : that.module.HYBRID_TYPE
		}; 	
	}	
};


/* Creates map object with latitude, longitude and zoom
	myObj.initMap(
	{
		latitude: 39.82,
		longitude: 32.78,
		zoom : 6
	});
*/
GoogleMaps.prototype.initMap = function (params) 
{
	var that = this;
	 	
	if ( that.platform == "android" )
	{
		that.mapView = that.module.createView({
		    userLocation: true,
		    mapType: that.module.NORMAL_TYPE,
		    animate: true,
		    region: {latitude: params.latitude, longitude: params.longitude, latitudeDelta: 0.1, longitudeDelta: 0.1 },
		    height: params.height,
		    top: params.top,
		    left: params.left,
		    right: params.right,
		    bottom: params.bottom,
		    width: params.width	    
		});
		that.mapObj = that.mapView;
		//that.mapObj.zoom(params.zoom); //TODO: bunu android cihazda kontrol et!
		
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj = that.module.createView({
			location: {
				latitude: params.latitude, 
				longitude: params.longitude
			},
			zoom: params.zoom
		});	
						
		that.mapView = Titanium.UI.createView({
		    height: params.height,
		    top: params.top,
		    left: params.left,
		    right: params.right,
		    bottom: params.bottom,
		    width: params.width
		}); 
		
		that.mapView.add(that.mapObj);
	}
	
	return that.mapView;
};


/* Change the center of map latitude and longitude
	myObj.setLocation(
	{
		latitude: 39.82,
		longitude: 32.78
	});
*/
GoogleMaps.prototype.setLocation = function (params)
{
	var that = this;
	 	
	if ( that.platform == "android" )
	{
		that.mapObj.setLocation({
			latitude: params.latitude,
			longitude: params.longitude,	
    		animate:true,
    		latitudeDelta:0.1, longitudeDelta:0.1 
    	});
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.setLocation({
			latitude: params.latitude,
			longitude: params.longitude	
		});
	}	
};

/* Change the zoom level of map 
	myObj.setZoom(12);
*/
GoogleMaps.prototype.setZoom = function (zoomLevel)
{
	var that = this;
	 	
	if ( that.platform == "android")
	{
		that.mapObj.zoom(zoomLevel);
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.setZoom(zoomLevel);
	}	
};

/* Create Map Marker 
	myObj.createMarker({
		
	});
*/
GoogleMaps.prototype.createMarker = function (params)
{
	var that = this;
	var marker = null; 	
	
	if ( that.platform == "android")
	{
		marker = that.module.createAnnotation({
			latitude: params.latitude,
			longitude: params.longitude,
		    title:params.title,
		    subtitle:params.subtitle,
		    image:params.image + '.png', //TODO: check this on device
		    //pincolor: that.module.ANNOTATION_RED,
		    myid:1 // Custom property to uniquely identify this annotation.
		});		
	}
	else //iOS kısmını yazıyoruz. 
	{
		marker = that.module.createAnnotation({
			latitude: params.latitude,
			longitude: params.longitude,
			title: params.title,
			snippet: params.subtitle,
			markerIcon : params.image			
		})				
	}	
	
	return marker;
};


GoogleMaps.prototype.addMarker = function (marker)
{
	var that = this;	 	
	
	if ( that.platform == "android")
	{
		that.mapObj.addAnnotation(marker);
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.addAnnotation(marker);
	}		
};

GoogleMaps.prototype.createPolygon = function (params)
{
	var that = this;
	var polygon = null;
	 	
	if ( that.platform == "android")
	{
		Ti.API.info("There is no API for polygons!!!");
	}
	else //iOS kısmını yazıyoruz. 
	{
		polygon = that.module.createPolygon({
			"pathColor" : params.pathColor,
			"width": params.width,
			"fillColor": params.fillColor,
			"title": params.title,
			"tappable": params.tappable
		});
		polygon.createPath(params.path);			
	}
	return polygon;		
};

GoogleMaps.prototype.createPolyline = function (params)
{
	var that = this;
	var polyline = null
	
	if ( that.platform == "android" ) //TODO : test this function on Android Platform
	{		
		var pointLength = params.path.length;
		var androidPath = [];
		for(var i=0; i < pointLength; i++)
		{
			var mapPoint = {
				latitude: params.path[i][0],
				longitude: params.path[i][1] 
			};
			androidPath.push(mapPoint);
		}
		
		Ti.API.info(androidPath);	
		alert("sayı : " + androidPath.length);	
		
		polyline = that.module.createRoute({
			color: params.pathColor,
			width: params.width,
			points: androidPath
		});							
	}
	else //iOS kısmını yazıyoruz.
	{
		polyline = that.module.createPolyline({
			"pathColor" : params.pathColor,
			"width": params.width,
			"title": params.title,
			"tappable": params.tappable	
		});
		polyline.createPath(params.path);
	}
	
	return polyline;
};

GoogleMaps.prototype.addPolygon = function (polygon)
{
	var that = this;

	if ( that.platform == "android")
	{
		Ti.API.info("There is no API for polygons!!!");
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.addPolygon(polygon);
	}		
};

GoogleMaps.prototype.addPolyline = function (polyline)
{
	var that = this;

	if ( that.platform == "android") //TODO : test this function on Android Platform
	{
		that.mapObj.addRoute(polyline);
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.addPolyline(polyline);
	}		
};

GoogleMaps.prototype.changeBaseMap = function (mapType)
{
	var that = this;
	 	
	if ( that.platform == "android")
	{
		that.mapObj.setMapType(that.mapTypes[mapType]); //TODO : bu kısmı Android altında test edelim!
	}
	else //iOS kısmını yazıyoruz. 
	{
		that.mapObj.setMapType(that.mapTypes[mapType]);
	}	
};


//userLocation : Boolean (android) bunu da eklemeli mi?
//zoomControl ?






GoogleMaps.prototype.templateFunction = function (params)
{
	var that = this;
	 	
	if ( that.platform == "android")
	{
		
	}
	else //iOS kısmını yazıyoruz. 
	{
		
	}	
};

module.exports = GoogleMaps;


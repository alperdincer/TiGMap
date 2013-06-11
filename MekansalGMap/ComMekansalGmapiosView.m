/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComMekansalGmapiosView.h"
#import "ComMekansalGmapiosAnnotationProxy.h"
#import "ComMekansalGmapiosTileLayerProxy.h"
#import "ComMekansalGmapiosPolylineProxy.h"
#import "ComMekansalGmapiosPolygonProxy.h"

@implementation ComMekansalGmapiosView

-(id)init
{
    if (self = [super init]) {
		_location = CLLocationCoordinate2DMake(0,0);
		_zoom = 0;
		_rendered = NO;
		_animate = YES;
		_locChanged = NO;
		_zoomChanged = NO;
		_bearingChanged = NO;
		_angleChanged = NO;
		_annotationsAdded = [[NSMutableArray alloc] init];
        _tileLayersAdded = [[NSMutableArray alloc] init];
        _polylinesAdded = [[NSMutableArray alloc] init];
        _polygonsAdded = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)dealloc
{
	if (_map!=nil)
	{
		_map.delegate = nil;
		RELEASE_TO_NIL(_map);
	}
    
	RELEASE_TO_NIL(_annotationsAdded);
    RELEASE_TO_NIL(_tileLayersAdded);
    RELEASE_TO_NIL(_polylinesAdded);
    RELEASE_TO_NIL(_polygonsAdded);
    
	[super dealloc];
}

- (GMSMapView *) map
{
	if (_map==nil)
	{
		//CGRect aRect = CGRectMake(aPoint.x, aPoint.y, aSize.width, aSize.height);
        
        _map = [[GMSMapView alloc] initWithFrame:self.bounds];
		//GMSCameraPosition* camera = [GMSCameraPosition cameraWithLatitude:1.285 longitude:103.848 zoom:12];
		//_map = [GMSMapView mapWithFrame:self.bounds camera:camera];
		_map.myLocationEnabled = YES;
        _map.delegate = self;
        //_map.projection.visibleRegion.farLeft.latitude
		[self addSubview:_map];
	}
    
	return _map;
}

-(void)render
{
	if (_map==nil) // before mapview initialized
	{
		return;
	}
    
	if (![NSThread isMainThread]) {
		TiThreadPerformOnMainThread(^{[self render];}, NO);
		return;
	}
    
	if (!_rendered || !_animate) {
		CLLocationCoordinate2D target = _map.camera.target;
		if (_locChanged) {
			target = _location;
		}
		CGFloat zoom = _map.camera.zoom;
		if (_zoomChanged) {
			zoom = _zoom;
		}
		CLLocationDirection bearing = _map.camera.bearing;
		if (_bearingChanged) {
			bearing = _bearing;
		}
		double angle = _map.camera.viewingAngle;
		if (_angleChanged) {
			angle = _angle;
		}
        
		GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:target
                                                                   zoom:zoom
                                                                bearing:bearing
                                                           viewingAngle:angle ];
        
		[_map setCamera: camera];
	}
	else {
		if (_locChanged) {
			[_map animateToLocation:_location];
		}
		if (_zoomChanged) {
			[_map animateToZoom: _zoom];
		}
		if (_bearingChanged) {
			[_map animateToBearing: _bearing];
		}
		if (_angleChanged) {
			[_map animateToViewingAngle: _angle];
		}
	}
	_locChanged = NO;
	_zoomChanged = NO;
	_bearingChanged = NO;
	_angleChanged = NO;
}

- (void)frameSizeChanged:(CGRect)frame bounds:(CGRect)bounds
{
	[TiUtils setView:[self map] positionRect:bounds];
	[super frameSizeChanged:frame bounds:bounds];
	[self render];
	_rendered = YES;
}

-(UIView*)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    UIView* result = [super hitTest:point withEvent:event];
	if(result==self){
		return nil;
	}
	return result;
}

-(ComMekansalGmapiosAnnotationProxy*) proxyForMarker:(GMSMarker *)marker
{
	ENSURE_UI_THREAD(proxyForMarker,marker);
    
    for (id annProxy in _annotationsAdded)
	{
		if ([annProxy isKindOfClass:[ComMekansalGmapiosAnnotationProxy class]])
		{
			GMSMarker* m = [(ComMekansalGmapiosAnnotationProxy*)annProxy markerObj];
			if ( m!=nil && m==marker )
			{
				return annProxy;
			}
		}
	}
	return nil;
}

-(ComMekansalGmapiosTileLayerProxy*) proxyForTileLayer:(GMSTileLayer *)tileLayer
{
	ENSURE_UI_THREAD(proxyForTileLayer,tileLayer);
    
    for (id tileProxy in _tileLayersAdded)
	{
		if ([tileProxy isKindOfClass:[ComMekansalGmapiosTileLayerProxy class]])
		{
			GMSTileLayer* t = [(ComMekansalGmapiosTileLayerProxy*)tileProxy tileLayerObj];
			if ( t!=nil && t==tileLayer )
			{
				return tileProxy;
			}
		}
	}
	return nil;
}

-(ComMekansalGmapiosPolylineProxy*) proxyForPolyline:(GMSPolyline *)polyline
{
	ENSURE_UI_THREAD(proxyForPolyline,polyline);
    
    for (id polylineProxy in _polylinesAdded)
	{
		if ([polylineProxy isKindOfClass:[ComMekansalGmapiosPolylineProxy class]])
		{
			GMSPolyline* t = [(ComMekansalGmapiosPolylineProxy*)polylineProxy polylineObj];
			if ( t!=nil && t==polyline )
			{
				return polylineProxy;
			}
		}
	}
	return nil;
}

-(ComMekansalGmapiosPolygonProxy*) proxyForPolygon:(GMSPolygon *)polygon
{
	ENSURE_UI_THREAD(proxyForPolygon,polygon);
    
    for (id polygonProxy in _polylinesAdded)
	{
		if ([polygonProxy isKindOfClass:[ComMekansalGmapiosPolygonProxy class]])
		{
			GMSPolygon* t = [(ComMekansalGmapiosPolygonProxy*)polygonProxy polygonObj];
			if ( t!=nil && t==polygon )
			{
				return polygonProxy;
			}
		}
	}
	return nil;
}

#pragma mark Public APIs

-(void)setLocation_:(id)location
{
	ENSURE_SINGLE_ARG(location,NSDictionary);
    ENSURE_UI_THREAD(setLocation_,location)
	id lat = [location objectForKey:@"latitude"];
	id lon = [location objectForKey:@"longitude"];
	if (lat)
	{
		_location.latitude = [lat doubleValue];
	}
	if (lon)
	{
		_location.longitude = [lon doubleValue];
	}
    
	_locChanged = YES;
	[self render];
}

-(void)setZoom_:(id)zoom
{
	ENSURE_SINGLE_ARG(zoom,NSObject);
	ENSURE_UI_THREAD(setZoom_,zoom);
    
	_zoom = [TiUtils floatValue:zoom];
    
	_zoomChanged = YES;
	[self render];
}

-(void)setBearing_:(id)bearing
{
	ENSURE_SINGLE_ARG(bearing,NSObject);
	ENSURE_UI_THREAD(setBearing_,bearing);
    
	_bearing = [TiUtils doubleValue:bearing];
    
	_bearingChanged = YES;
	[self render];
}

-(void)setViewingAngle_:(id)angle
{
	ENSURE_SINGLE_ARG(angle,NSObject);
	ENSURE_UI_THREAD(setViewingAngle_,angle);
    
	_angle = [TiUtils doubleValue:angle];
    
	_angleChanged = YES;
	[self render];
}

-(void)setAnimate_:(id)animate
{
	ENSURE_SINGLE_ARG(animate,NSObject);
	_animate = [TiUtils boolValue:animate];
}

-(void)setMapType_:(id)value
{
	[[self map] setMapType:[TiUtils intValue:value]];
}

-(void)setScrollGesture_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setScrollGesture_,gestures);
    
    //bool scroll = [TiUtils boolValue:[gestures valueForUndefinedKey:@"scroll"]];
    bool scroll = [TiUtils boolValue:gestures];
    self.map.settings.scrollGestures = scroll;
    
    //NSLog(@"Zoom parametresi : %d", scroll);
    
    /*
    if (scroll)
    {
        NSLog(@"Scroll parametresi enabled!");
    }
    else
    {
        NSLog(@"Scroll parametresi disabled!");
    }*/
}

-(void)setZoomGesture_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setZoomGesture_,gestures);
    
    bool zoom = [TiUtils boolValue:gestures];
    self.map.settings.zoomGestures = zoom;
    //NSLog(@"Zoom parametresi : %d", zoom);
}

-(void)setTiltGesture_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setTiltGesture_,gestures);
    
    bool tilt = [TiUtils boolValue:gestures];
    self.map.settings.tiltGestures = tilt;
    //NSLog(@"Tilt parametresi : %d", tilt);
}

-(void)setRotateGesture_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setRotateGesture_,gestures);
    
    bool rotate = [TiUtils boolValue:gestures];
    self.map.settings.rotateGestures = rotate;
    //NSLog(@"Rotate parametresi : %d", rotate);
}

-(void)setCompassButton_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setCompassButton_,gestures);
    
    bool compass = [TiUtils boolValue:gestures];
    self.map.settings.compassButton = compass;
    //NSLog(@"Rotate parametresi : %d", compass);
}

-(void)setLocationButton_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setLocationButton_,gestures);
    
    bool location = [TiUtils boolValue:gestures];
    self.map.settings.myLocationButton = location;
    //NSLog(@"Rotate parametresi : %d", location);
}

-(void)setMyLocation_:(id)gestures
{
	ENSURE_SINGLE_ARG(gestures,NSObject);
	ENSURE_UI_THREAD(setMyLocation_,gestures);
    
    bool location = [TiUtils boolValue:gestures];
    self.map.myLocationEnabled = location;
    //NSLog(@"Rotate parametresi : %d", location);
}

-(NSDictionary*)getBBOX_:(id)params
{
 	ENSURE_SINGLE_ARG(params,NSObject);
	ENSURE_UI_THREAD(getBBOX_, params);
    
    /*NSLog(@"BBOX : FarLeft : (%f, %f), farRight : (%f, %f), nearLeft : (%f, %f), nearRight : (%f, %f)",
          _map.projection.visibleRegion.farLeft.latitude, _map.projection.visibleRegion.farLeft.longitude,
          _map.projection.visibleRegion.farRight.latitude, _map.projection.visibleRegion.farRight.longitude,
          _map.projection.visibleRegion.nearLeft.latitude, _map.projection.visibleRegion.nearLeft.longitude,
          _map.projection.visibleRegion.nearRight.latitude, _map.projection.visibleRegion.nearRight.longitude
          );
     */
    NSDictionary *retVal = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farLeft.latitude], @"farLeftLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farLeft.longitude], @"farLeftLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farRight.latitude], @"farRightLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farRight.longitude], @"farRightLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearLeft.latitude], @"nearLeftLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearLeft.longitude], @"nearLeftLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearRight.latitude], @"nearRightLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearRight.longitude], @"nearRightLng",
                            nil];
    return retVal;
}

-(void)addAnnotation:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(addAnnotation,arg);
    
	ComMekansalGmapiosAnnotationProxy* annProxy = arg;
    
	if (annProxy!=nil && ![_annotationsAdded containsObject:annProxy]) {
		[_annotationsAdded addObject:annProxy];
		[annProxy addToMap:[self map]];
	}
}

-(void)removeAnnotation:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(removeAnnotation,arg);
    
	ComMekansalGmapiosAnnotationProxy *annProxy = arg;
    
	if (annProxy!=nil && [_annotationsAdded containsObject:annProxy]) {
		[_annotationsAdded removeObject:annProxy];
		[annProxy removeFromMap:[self map]];
	}
}


-(void)addTileLayer:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(addTileLayer,arg);
    
	ComMekansalGmapiosTileLayerProxy* tileProxy = arg;
    
	if (tileProxy!=nil && ![_tileLayersAdded containsObject:tileProxy]) {
		[_tileLayersAdded addObject:tileProxy];
		[tileProxy addToMap:[self map]];
	}
}

-(void)removeTileLayer:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(removeTileLayer,arg);
    
	ComMekansalGmapiosTileLayerProxy *tileProxy = arg;
    
	if (tileProxy!=nil && [_tileLayersAdded containsObject:tileProxy]) {
		[_tileLayersAdded removeObject:tileProxy];
		[tileProxy removeFromMap:[self map]];
	}
}

-(NSDictionary*)showBBOX
{
    /*NSLog(@"BBOX : FarLeft : (%f, %f), farRight : (%f, %f), nearLeft : (%f, %f), nearRight : (%f, %f)",
          _map.projection.visibleRegion.farLeft.latitude, _map.projection.visibleRegion.farLeft.longitude,
          _map.projection.visibleRegion.farRight.latitude, _map.projection.visibleRegion.farRight.longitude,
          _map.projection.visibleRegion.nearLeft.latitude, _map.projection.visibleRegion.nearLeft.longitude,
          _map.projection.visibleRegion.nearRight.latitude, _map.projection.visibleRegion.nearRight.longitude
          );
    */
    NSDictionary *retVal = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farLeft.latitude], @"farLeftLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farLeft.longitude], @"farLeftLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farRight.latitude], @"farRightLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.farRight.longitude], @"farRightLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearLeft.latitude], @"nearLeftLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearLeft.longitude], @"nearLeftLng",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearRight.latitude], @"nearRightLat",
                            [NSNumber numberWithDouble:_map.projection.visibleRegion.nearRight.longitude], @"nearRightLng",
                            nil];
    return retVal;
}

-(void)addPolyline:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(addPolyline,arg);
    
	ComMekansalGmapiosPolylineProxy* polylineProxy = arg;
    
	if (polylineProxy!=nil && ![_polylinesAdded containsObject:polylineProxy]) {
		[_polylinesAdded addObject:polylineProxy];
		[polylineProxy addToMap:[self map]];
	}
}

-(void)removePolyline:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(removePolyline,arg);
    
	ComMekansalGmapiosPolylineProxy* polylineProxy = arg;
    
	if (polylineProxy!=nil && [_polylinesAdded containsObject:polylineProxy]) {
        [_polylinesAdded removeObject:polylineProxy];
		[polylineProxy removeFromMap:[self map]];
	}
}

-(void)addPolygon:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(addPolygon,arg);
    
	ComMekansalGmapiosPolygonProxy* polygonProxy = arg;
    
	if (polygonProxy!=nil && ![_polygonsAdded containsObject:polygonProxy]) {
		[_polygonsAdded addObject:polygonProxy];
		[polygonProxy addToMap:[self map]];
	}
}

-(void)removePolygon:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(removePolygon,arg);
    
	ComMekansalGmapiosPolygonProxy* polygonProxy = arg;
    
	if (polygonProxy!=nil && [_polygonsAdded containsObject:polygonProxy]) {
        [_polygonsAdded removeObject:polygonProxy];
		[polygonProxy removeFromMap:[self map]];
	}
}


#pragma mark Delegates

- (void)mapView:(GMSMapView *)mapView
didChangeCameraPosition:(GMSCameraPosition *)position
{
	if ([self.proxy _hasListeners:@"changeCameraPosition"]) // listener name is too long?
	{
		NSDictionary *target = [NSDictionary dictionaryWithObjectsAndKeys:
                                [NSNumber numberWithDouble:position.target.latitude],@"latitude",
                                [NSNumber numberWithDouble:position.target.longitude],@"longitude",
                                nil];
		NSDictionary *props = [NSDictionary dictionaryWithObjectsAndKeys:
                               @"changeCameraPosition",@"type",
                               target,@"target",
                               [NSNumber numberWithDouble:position.zoom],@"zoom",
                               [NSNumber numberWithDouble:position.bearing],@"bearing",
                               [NSNumber numberWithDouble:position.viewingAngle],@"viewAngle",
                               [self showBBOX],@"bbox",
                               nil];
		[self.proxy fireEvent:@"changeCameraPosition" withObject:props];
	}
}

- (void)mapView:(GMSMapView *)mapView
didTapAtCoordinate:(CLLocationCoordinate2D)coordinate
{
	if ([self.proxy _hasListeners:@"click"])
	{
		NSDictionary * props = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"click",@"type",
                                [NSNumber numberWithDouble:coordinate.latitude],@"latitude",
                                [NSNumber numberWithDouble:coordinate.longitude],@"longitude",
                                nil];
		[self.proxy fireEvent:@"click" withObject:props];
	}
}

- (void)mapView:(GMSMapView *)mapView
didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate
{
	if ([self.proxy _hasListeners:@"longpress"])
	{
		NSDictionary * props = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"longpress",@"type",
                                [NSNumber numberWithDouble:coordinate.latitude],@"latitude",
                                [NSNumber numberWithDouble:coordinate.longitude],@"longitude",
                                nil];
		[self.proxy fireEvent:@"longpress" withObject:props];
	}
}
-(void)recognizedLongPress:(UILongPressGestureRecognizer*)recognizer
{
	// ignore the event by recognized in TiUIView
}


- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(GMSMarker *)marker
{
	ComMekansalGmapiosAnnotationProxy *annProxy = [self proxyForMarker:marker];
	if ([annProxy _hasListeners:@"click"])
	{
		NSDictionary * props = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"click",@"type",
                                nil];
		[annProxy fireEvent:@"click" withObject:props];
	}
	//return YES;
}

- (void)mapView:(GMSMapView *)mapView
didTapInfoWindowOfMarker:(GMSMarker *)marker
{
	ComMekansalGmapiosAnnotationProxy *annProxy = [self proxyForMarker:marker];
	if ([annProxy _hasListeners:@"infoWindowClick"])
	{
		NSDictionary * props = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"infoWindowClick",@"type",
                                nil];
		[annProxy fireEvent:@"infoWindowClick" withObject:props];
	}
}

- (void)mapView:(GMSMapView *)mapView didTapOverlay:(GMSOverlay *)overlay
{
    if ([self.proxy _hasListeners:@"overlayClick"])
    {
		NSDictionary * props = [NSDictionary dictionaryWithObjectsAndKeys:
                                @"overlayClick",@"type",
                                overlay.title, @"overlayTitle",
                                nil];
        [self.proxy fireEvent:@"overlayClick" withObject:props];
    }
}


//- (UIView *)mapView:(GMSMapView *)mapView
//    markerInfoWindow:(id<GMSMarker>)marker
//{
//}


@end

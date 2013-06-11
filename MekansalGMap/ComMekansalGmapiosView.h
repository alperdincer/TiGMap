/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import <UIKit/UIKit.h>
#import "TiUIView.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ComMekansalGmapiosView : TiUIView<GMSMapViewDelegate> {
	GMSMapView * _map;
    
	CLLocationCoordinate2D _location;
	CGFloat _zoom;
	CLLocationDirection _bearing;
	double _angle;
	BOOL _locChanged;
	BOOL _zoomChanged;
	BOOL _bearingChanged;
	BOOL _angleChanged;
    
	BOOL _rendered;
	BOOL _animate;
    
	NSMutableArray* _annotationsAdded; // Annotations to add on initial display
    NSMutableArray* _tileLayersAdded;
    NSMutableArray* _polylinesAdded;
    NSMutableArray* _polygonsAdded;
}

-(void)addAnnotation:(id)args;
//-(void)addAnnotations:(id)args;
-(void)removeAnnotation:(id)args;
//-(void)removeAnnotations:(id)args;
//-(void)removeAllAnnotations:(id)args;

-(void)addTileLayer:(id)args;
-(void)removeTileLayer:(id)args;
-(NSDictionary*)showBBOX;
-(void)addPolyline:(id)args;
-(void)removePolyline:(id)args;
-(void)addPolygon:(id)args;
-(void)removePolygon:(id)args;

@end

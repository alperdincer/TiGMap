/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */
#import "TiProxy.h"
#import <GoogleMaps/GoogleMaps.h>

@interface ComMekansalGmapiosAnnotationProxy : TiProxy {
    GMSMarker * _markerObj;
}

@property (nonatomic, readwrite, retain) GMSMarker *markerObj;

- (UIColor *)colorFromHexString:(NSString *)hexString;
-(void)addToMap:(GMSMapView *)mapView;
-(void)removeFromMap:(GMSMapView *)mapView;

@end

/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComMekansalGmapiosPolylineProxy.h"
#import "TiUtils.h"

@implementation ComMekansalGmapiosPolylineProxy

-(void)dealloc
{
    if (_polylineObj!=nil)
    {
		_polylineObj.map = nil;
		RELEASE_TO_NIL(_polylineObj);
	}
	[super dealloc];
}

-(void)createPath:(NSArray*)args
{
    ENSURE_UI_THREAD(createPath,args);
    if (self.path == nil)
    {
        self.path = [GMSMutablePath path];

        NSArray *msg = (NSArray*)[args objectAtIndex: 0];
        
        for (NSArray *item in msg)
        {
            float lat = [[item objectAtIndex:0] floatValue];
            float lng = [[item objectAtIndex:1] floatValue];
            [self.path addCoordinate:CLLocationCoordinate2DMake(lat, lng)];
        }
    }
}

-(void)addToMap:(GMSMapView *)mapView
{
	ENSURE_UI_THREAD(addToMap, mapView);
        
    if (self.path != nil)
    {
        self.polylineObj = [GMSPolyline polylineWithPath:self.path];
        
        NSString *pathColor = [TiUtils stringValue:[self valueForUndefinedKey:@"pathColor"]];
        if (pathColor != nil)
        {
            self.polylineObj.strokeColor = [self colorFromHexString:pathColor];
        }
        
        NSString *title = [TiUtils stringValue:[self valueForUndefinedKey:@"title"]];
        if (title != nil)
        {
            self.polylineObj.title = title;
        }
        
        bool tappable = [TiUtils boolValue:[self valueForUndefinedKey:@"tappable"]];
        if (tappable)
        {
            self.polylineObj.tappable = true;
        }
        
        float width = [TiUtils floatValue:[self valueForUndefinedKey:@"width"]];
        if (width != 0.0)
        {
            self.polylineObj.strokeWidth = width;
        }
        
        self.polylineObj.map = mapView;
    }
    else
    {
        NSLog(@"There is no path defined for polyline!");
    }
}
-(void)removeFromMap:(GMSMapView *)mapView
{
	ENSURE_UI_THREAD(removeFromMap, mapView);
	if (_polylineObj!=nil)
	{
        _polylineObj.map = nil;
		RELEASE_TO_NIL(_polylineObj);
	}
}


- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}



@end

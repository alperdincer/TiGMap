/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComMekansalGmapiosAnnotationProxy.h"
#import "TiUtils.h"


@implementation ComMekansalGmapiosAnnotationProxy

-(void)dealloc
{
    if (_markerObj!=nil)
    {
		_markerObj.map = nil;
		RELEASE_TO_NIL(_markerObj);
	}
	[super dealloc];
}

-(void)addToMap:(GMSMapView *)mapView
{
	self.markerObj = [GMSMarker markerWithPosition:CLLocationCoordinate2DMake(
                                                                              [TiUtils doubleValue:[self valueForUndefinedKey:@"latitude"]],
                                                                              [TiUtils doubleValue:[self valueForUndefinedKey:@"longitude"]] ) ];
	self.markerObj.title = [TiUtils stringValue:[self valueForUndefinedKey:@"title"]];
	self.markerObj.snippet = [TiUtils stringValue:[self valueForUndefinedKey:@"snippet"]];
    
    NSString *markerColor = [TiUtils stringValue:[self valueForUndefinedKey:@"markerColor"]];
    if (markerColor != nil)
    {
        self.markerObj.icon = [GMSMarker markerImageWithColor:[self colorFromHexString:markerColor]];
    }

    NSString *markerIcon = [TiUtils stringValue:[self valueForUndefinedKey:@"markerIcon"]];
    if (markerIcon != nil)
    {
        self.markerObj.icon = [UIImage imageNamed:markerIcon];
    }
    
	self.markerObj.map = mapView;
}
-(void)removeFromMap:(GMSMapView *)mapView
{
	if (_markerObj!=nil)
	{
		_markerObj.map = nil;
		RELEASE_TO_NIL(_markerObj);
	}
}

-(void)setLatitude:(id)latitude
{
	double curValue = [TiUtils doubleValue:[self valueForUndefinedKey:@"latitude"]];
	double newValue = [TiUtils doubleValue:latitude];
	[self replaceValue:latitude forKey:@"latitude" notification:NO];
}

-(void)setLongitude:(id)longitude
{
	double curValue = [TiUtils doubleValue:[self valueForUndefinedKey:@"longitude"]];
	double newValue = [TiUtils doubleValue:longitude];
	[self replaceValue:longitude forKey:@"longitude" notification:NO];
}

- (NSString *)title
{
	return [self valueForUndefinedKey:@"title"];
}

-(void)setTitle:(id)title
{
	NSString *newValue = [TiUtils stringValue:[self valueForUndefinedKey:@"title"]];
	NSString *curValue = [TiUtils stringValue:title];
    //	title = [TiUtils replaceString:[TiUtils stringValue:title]
    //			characters:[NSCharacterSet newlineCharacterSet] withString:@" "];
    //	//The label will strip out these newlines anyways (Technically, replace them with spaces)
    //	id current = [self valueForUndefinedKey:@"title"];
	[self replaceValue:title forKey:@"title" notification:NO];
}

-(void)setSnippet:(id)snippet
{
	NSString *newValue = [TiUtils stringValue:[self valueForUndefinedKey:@"snippet"]];
	NSString *curValue = [TiUtils stringValue:snippet];
	[self replaceValue:snippet forKey:@"snippet" notification:NO];
}

- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1]; // bypass '#' character
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}



@end

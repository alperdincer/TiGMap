/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComMekansalGmapiosTileLayerProxy.h"
#import "TiUtils.h"

@implementation ComMekansalGmapiosTileLayerProxy

-(void)dealloc
{
    if (_tileLayerObj!=nil)
    {
		_tileLayerObj.map = nil;
		RELEASE_TO_NIL(_tileLayerObj);
	}
	[super dealloc];
}

-(void)addToMap:(GMSMapView *)mapView
{
    NSString *tileUrl = [TiUtils stringValue:[self valueForUndefinedKey:@"tileUrl"]];
    if (tileUrl != nil)
    {
        GMSTileURLConstructor urlConst = ^(NSUInteger x, NSUInteger y, NSUInteger zoom) {
            //NSString *url = [NSString stringWithFormat:@"http://tilesrv01.dsi.gov.tr/basemap/%d/%d/%d.png",zoom, x, y];
            NSString *url = [NSString stringWithFormat:tileUrl,zoom, x, y];
            return [NSURL URLWithString:url];
        };
        
        self.tileLayerObj = [GMSURLTileLayer tileLayerWithURLConstructor:urlConst];

        int tileZIndex = [TiUtils intValue:[self valueForUndefinedKey:@"zindex"]];
        self.tileLayerObj.zIndex = tileZIndex;

        self.tileLayerObj.map = mapView;

    }
    else {
        NSLog(@"No tile Url format is given!!!");
    }
    
}
-(void)removeFromMap:(GMSMapView *)mapView
{
	if (_tileLayerObj!=nil)
	{
		_tileLayerObj.map = nil;
		RELEASE_TO_NIL(_tileLayerObj);
	}
}

@end

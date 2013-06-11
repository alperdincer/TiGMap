/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "ComMekansalGmapiosModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

#import <GoogleMaps/GoogleMaps.h>

@implementation ComMekansalGmapiosModule

MAKE_SYSTEM_PROP(NORMAL_TYPE, kGMSTypeNormal); // Basic maps.
MAKE_SYSTEM_PROP(SATELLITE_TYPE,kGMSTypeSatellite); // Satellite maps with no labels.
MAKE_SYSTEM_PROP(TERRAIN_TYPE,kGMSTypeTerrain); // Terrain maps.
MAKE_SYSTEM_PROP(HYBRID_TYPE,kGMSTypeHybrid); // Satellite maps with a transparent label overview.
MAKE_SYSTEM_PROP(NOMAP_TYPE,kGMSTypeNone); //Altlık haritaları kapatıyoruz

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"45cae3da-4232-49d0-ba7e-0b65ce0bc932";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"com.mekansal.gmapios";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"my_event"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"my_event"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs

#pragma Public APIs

-(void)setAPIKey:(id)value
{
	[GMSServices provideAPIKey:[TiUtils stringValue:value]];
}

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)setExampleProp:(id)value
{
	// example property setter
}

@end

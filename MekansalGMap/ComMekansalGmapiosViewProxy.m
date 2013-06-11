/**
 * Appcelerator Titanium Mobile
 * Copyright (c) 2009-2013 by Appcelerator, Inc. All Rights Reserved.
 * Licensed under the terms of the Apache Public License
 * Please see the LICENSE included with this distribution for details.
 */

#import "ComMekansalGmapiosViewProxy.h"
#import "ComMekansalGmapiosView.h"
#import "ComMekansalGmapiosAnnotationProxy.h"
#import "ComMekansalGmapiosTileLayerProxy.h"
#import "TiUtils.h"

@implementation ComMekansalGmapiosViewProxy

-(void)dealloc
{
    if (_globalDict!=nil)
    {
		RELEASE_TO_NIL(_globalDict);
	}
	[super dealloc];
}

-(void)addAnnotation:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
	ENSURE_UI_THREAD(addAnnotation,arg);
    
    ComMekansalGmapiosAnnotationProxy* annProxy = arg;
    [self rememberProxy:annProxy];
    
	//if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{[(ComMekansalGmapiosView*)[self view] addAnnotation:arg];}, NO);
	}
    //	else
    //	{
    //		if (annotationsToAdd==nil)
    //		{
    //			annotationsToAdd = [[NSMutableArray alloc] init];
    //		}
    //		if (annotationsToRemove!=nil && [annotationsToRemove containsObject:arg])
    //		{
    //			[annotationsToRemove removeObject:arg];
    //		}
    //		else
    //		{
    //			[annotationsToAdd addObject:arg];
    //		}
    //	}
}

-(void)removeAnnotation:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(removeAnnotation,arg);
	
    if ([arg isKindOfClass:[ComMekansalGmapiosAnnotationProxy class]]) {
		[self forgetProxy:arg];
	}
    
	//if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] removeAnnotation:arg];
		}, NO);
	}
    //	else
    //	{
    //		if (annotationsToRemove==nil)
    //		{
    //			annotationsToRemove = [[NSMutableArray alloc] init];
    //		}
    //		if (annotationsToAdd!=nil && [annotationsToAdd containsObject:arg])
    //		{
    //			[annotationsToAdd removeObject:arg];
    //		}
    //		else 
    //		{
    //			[annotationsToRemove addObject:arg];
    //		}
    //	}
}

-(void)addTileLayer:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(addTileLayer,arg);
    
	ComMekansalGmapiosTileLayerProxy* tileProxy = arg;
    [self rememberProxy:tileProxy];
    
	//if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{[(ComMekansalGmapiosView*)[self view] addTileLayer:arg];}, NO);
	}
    //	else
    //	{
    //		if (annotationsToAdd==nil)
    //		{
    //			annotationsToAdd = [[NSMutableArray alloc] init];
    //		}
    //		if (annotationsToRemove!=nil && [annotationsToRemove containsObject:arg])
    //		{
    //			[annotationsToRemove removeObject:arg];
    //		}
    //		else
    //		{
    //			[annotationsToAdd addObject:arg];
    //		}
    //	}
}

-(void)removeTileLayer:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(removeTileLayer,arg);
    
	if ([arg isKindOfClass:[ComMekansalGmapiosTileLayerProxy class]]) {
		[self forgetProxy:arg];
	}
    
	//if ([self viewAttached])
	{
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] removeTileLayer:arg];
		}, NO);
	}
    //	else
    //	{
    //		if (annotationsToRemove==nil)
    //		{
    //			annotationsToRemove = [[NSMutableArray alloc] init];
    //		}
    //		if (annotationsToAdd!=nil && [annotationsToAdd containsObject:arg])
    //		{
    //			[annotationsToAdd removeObject:arg];
    //		}
    //		else
    //		{
    //			[annotationsToRemove addObject:arg];
    //		}
    //	}
}

//TODO : Bu fonksiyonu yeniden düzenle!!!
/*
-(NSDictionary*)showBBOX:(id)arg
{
	ENSURE_SINGLE_ARG(arg,NSObject);
    //ENSURE_UI_THREAD(showBBOX, arg);
    
    NSDictionary *retVal = [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithDouble:39.99292], @"farLeftLat",
                            [NSNumber numberWithDouble:32.1232], @"farLeftLng",
                            nil];
    //return retVal; 

    __block NSDictionary *myDict;
    
    TiThreadPerformOnMainThread(^{
        //myDict = [(ComMekansalGmapiosView*)[self view] showBBOX];
        _globalDict = [(ComMekansalGmapiosView*)[self view] showBBOX];
        //NSLog(@"myDict : %@", [myDict description]);
        NSLog(@"myDict : %@", [_globalDict description]);
        //return myDict;
    }, YES);
    
    NSLog(@"myDict 2 : %@", [_globalDict description]);
    
    return retVal;
    //return myDict;
    //return [(ComMekansalGmapiosView*)[self view] showBBOX];
    //
    //id *dict;
    //{
	//	TiThreadPerformOnMainThread(^{
    //        [(ComMekansalGmapiosView*)[self view] showBBOX];
	//	}, NO);
	//}
    
}
*/

-(void)addPolyline:(id)arg
{
    ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(addPolyline,arg);

    {
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] addPolyline:arg];
		}, NO);
	}
}

-(void)removePolyline:(id)arg
{
    ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(removePolyline,arg);
    
    {
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] removePolyline:arg];
		}, NO);
	}
}

-(void)addPolygon:(id)arg
{
    ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(addPolygon,arg);
    
    {
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] addPolygon:arg];
		}, NO);
	}
}

-(void)removePolygon:(id)arg
{
    ENSURE_SINGLE_ARG(arg,NSObject);
    ENSURE_UI_THREAD(removePolygon,arg);
    
    {
		TiThreadPerformOnMainThread(^{
            [(ComMekansalGmapiosView*)[self view] removePolygon:arg];
		}, NO);
	}
}

@end

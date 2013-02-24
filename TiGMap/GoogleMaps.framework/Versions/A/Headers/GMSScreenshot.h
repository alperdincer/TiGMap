//
//  GMSScreenshot.h
//  Google Maps SDK for iOS
//
//  Copyright 2013 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <UIKit/UIKit.h>

@interface GMSScreenshot : NSObject

/** Takes a screenshot of the windows on the main screen. */
+ (UIImage *)screenshotOfMainScreen;

/** Takes a screenshot of the windows on the given screen. */
+ (UIImage *)screenshotOfScreen:(UIScreen *)screen;

@end

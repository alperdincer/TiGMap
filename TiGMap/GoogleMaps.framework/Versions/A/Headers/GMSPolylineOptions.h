//
//  GMSPolylineOptions.h
//  Google Maps SDK for iOS
//
//  Copyright 2012 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

@class GMSPath;

/**
 * Contains options used to configure a polyline.
 */
@interface GMSPolylineOptions : NSObject<NSCopying>

/** The path that describes this polyline. */
@property (nonatomic, copy) GMSPath *path;

/** The UIColor used to render the polyline. Defaults to blueColor. */
@property (nonatomic, strong) UIColor *color;

/** The width of the line in screen points. Defaults to 1. */
@property (nonatomic, assign) float width;

/** If this line should be rendered with geodesic correction. */
@property (nonatomic, assign) BOOL geodesic;

/**
 * The accessibility label of this polyline, as per the UIAccessibility
 * protocol.
 */
@property (nonatomic, copy) NSString *accessibilityLabel;

/** Convenience constructor for default initialized options. */
+ (GMSPolylineOptions *)options;

@end

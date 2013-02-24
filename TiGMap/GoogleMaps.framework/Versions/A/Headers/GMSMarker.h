//
//  GMSMarker.h
//  Google Maps SDK for iOS
//
//  Copyright 2012 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <CoreLocation/CoreLocation.h>

/**
 * A marker on a map.
 */
@protocol GMSMarker <NSObject>

/** Marker position. */
@property (nonatomic, assign) CLLocationCoordinate2D position;

/** Title text, shown prominently in the info window when selected. */
@property (nonatomic, copy) NSString *title;

/** Snippet text, shown beneath the title in the info window when selected. */
@property (nonatomic, copy) NSString *snippet;

/** Marker icon to render. If left nil, uses a default SDK place marker. */
@property (nonatomic, strong) UIImage *icon;

/**
 * The ground anchor specifies the point in the icon image that is anchored to
 * the marker's position on the Earth's surface. This point is specified within
 * the continuous space [0.0, 1.0] x [0.0, 1.0], where (0,0) is the top-left
 * corner of the image, and (1,1) is the bottom-right corner.
 */
@property (nonatomic, assign) CGPoint groundAnchor;

/**
 * The info window anchor specifies the point in the icon image at which to
 * anchor the info window, which will be displayed directly above this point.
 * This point is specified within the same space as groundAnchor.
 */
@property (nonatomic, assign) CGPoint infoWindowAnchor;

/**
 * The accessibility label of this marker, as per the UIAccessibility
 * protocol.  When this value is unset, the title will take precedence.
 */
@property (nonatomic, copy) NSString *accessibilityLabel;

/**
 * Marker data.  You can use this property to associate an arbitrary object with
 * this marker.  Google Maps SDK for iOS neither reads nor writes this property.
 *
 * Note that userData should not hold any strong references to any Maps
 * objects, otherwise a loop may be created (preventing ARC from releasing
 * objects).
 */
@property (nonatomic, strong) id userData;

/** Removes this marker from the map. */
- (void)remove;

@end

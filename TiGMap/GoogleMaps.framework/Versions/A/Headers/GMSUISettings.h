//
//  GMSUISettings.h
//  Google Maps SDK for iOS
//
//  Copyright 2012 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

@interface GMSUISettings : NSObject

/**
 * Controls whether scroll gestures are enabled (default) or disabled. If
 * enabled, users may swipe to pan the camera. This does not limit programmatic
 * movement of the camera.
 */
@property (nonatomic, assign) BOOL scrollGestures;

/**
 * Controls whether zoom gestures are enabled (default) or disabled. If
 * enabled, users may double tap/two-finger tap or pinch to zoom the camera.
 * This does not limit programmatic movement of the camera.
 *
 * Note that zoom gestures may allow the user to pan around the map, as a double
 * tap gesture will move the camera towards the specified point, and conversely
 * for two-finger tap to zoom out.
 */
@property (nonatomic, assign) BOOL zoomGestures;

/**
 * Controls whether tilt gestures are enabled (default) or disabled. If enabled,
 * users may use a two-finger vertical down or up swipe to tilt the camera. This
 * does not limit programmatic control of the camera's viewingAngle.
 */
@property (nonatomic, assign) BOOL tiltGestures;

/**
 * Controls whether rotate gestures are enabled (default) or disabled. If
 * enabled, users may use a two-finger rotate gesture to rotate the camera. This
 * does not limit programmatic control of the camera's bearing.
 */
@property (nonatomic, assign) BOOL rotateGestures;

@end

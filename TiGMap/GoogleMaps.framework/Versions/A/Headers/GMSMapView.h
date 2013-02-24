//
//  GMSMapView.h
//  Google Maps SDK for iOS
//
//  Copyright 2012 Google Inc.
//
//  Usage of this SDK is subject to the Google Maps/Google Earth APIs Terms of
//  Service: https://developers.google.com/maps/terms
//

#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

#import <GoogleMaps/GMSUISettings.h>

@class GMSCameraPosition;
@class GMSGroundOverlayOptions;
@class GMSMapView;
@class GMSMarkerOptions;
@class GMSPolylineOptions;
@class GMSProjection;

@protocol GMSGroundOverlay;
@protocol GMSMarker;
@protocol GMSPolyline;

@protocol GMSMapViewDelegate <NSObject>

@optional

/**
 * Called after the camera position has changed. During an animation, this
 * delegate might not be notified of intermediate camera positions. However, it
 * will always be called eventually with the final position of an the animation.
 */
- (void)mapView:(GMSMapView *)mapView
    didChangeCameraPosition:(GMSCameraPosition *)position;

/**
 * Called after a tap gesture at a particular coordinate, but only if a marker
 * was not tapped.  This is called before deselecting any currently selected
 * marker (the implicit action for tapping on the map).
 */
- (void)mapView:(GMSMapView *)mapView
    didTapAtCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 * Called after a long-press gesture at a particular coordinate.
 *
 * @param mapView The map view that was pressed.
 * @param coordinate The location that was pressed.
 */
- (void)mapView:(GMSMapView *)mapView
    didLongPressAtCoordinate:(CLLocationCoordinate2D)coordinate;

/**
 * Called after a marker has been tapped.
 *
 * @param mapView The map view that was pressed.
 * @param marker The marker that was pressed.
 * @return YES if this delegate handled the tap event, which prevents the map
 *         from performing its default selection behavior, and NO if the map
 *         should continue with its default selection behavior.
 */
- (BOOL)mapView:(GMSMapView *)mapView didTapMarker:(id<GMSMarker>)marker;

/**
 * Called after a marker's info window has been tapped.
 */
- (void)mapView:(GMSMapView *)mapView
    didTapInfoWindowOfMarker:(id<GMSMarker>)marker;

/**
 * Called when a marker is about to become selected, and provides an optional
 * custom info window to use for that marker if this method returns a UIView.
 * If you change this view after this method is called, those changes will not
 * necessarily be reflected in the rendered version.
 *
 * The returned UIView must not have bounds greater than 500 points on either
 * dimension.  As there is only one info window shown at any time, the returned
 * view may be reused between other info windows.
 *
 * @return The custom info window for the specified marker, or nil for default
 */
- (UIView *)mapView:(GMSMapView *)mapView
    markerInfoWindow:(id<GMSMarker>)marker;

@end

/**
 * Display types for GMSMapView.
 */
typedef enum {
  /** Basic maps.  The default. */
  kGMSTypeNormal = 1,

  /** Satellite maps with no labels. */
  kGMSTypeSatellite,

  /** Terrain maps. */
  kGMSTypeTerrain,

  /** Satellite maps with a transparent label overview. */
  kGMSTypeHybrid,

} GMSMapViewType;

/**
 * A map view.  This class should not be instantiated directly, instead it
 * must be created with [GMSServices mapWithFrame:camera:].
 *
 * GMSMapView is not thread safe, and should only be interacted with on the UI
 * thread.  This also follows for related objects such as markers and polylines.
 */
@interface GMSMapView : UIView

/** GMSMapView delegate. */
@property (nonatomic, weak) id<GMSMapViewDelegate> delegate;

/**
 * Controls the camera, which defines how the map is oriented.  If this property
 * is explicitly set, the camera is moved immediately, without animation; this
 * will also stop any previous animation.
 */
@property (nonatomic, strong) GMSCameraPosition *camera;

/**
 * The GMSProjection currently used by this GMSMapView. This is a snapshot of
 * the current projection, and will not automatically update when the camera
 * moves. The projection may be nil while the render is not running (if the map
 * is not yet part of your UI, or is part of a hidden UIViewController, or you
 * have called stopRendering).
 */
@property (nonatomic, readonly) GMSProjection *projection;

/**
 * Controls whether the My Location dot and accuracy circle is enabled.
 * Defaults to NO.
 */
@property (nonatomic, assign, getter=isMyLocationEnabled) BOOL myLocationEnabled;

/**
 * If My Location is enabled, reveals where the user location dot is being
 * drawn. If it is disabled, or it is enabled but no location data is available,
 * this will be nil.  This property is observable using KVO.
 */
@property (nonatomic, strong, readonly) CLLocation *myLocation;

/**
 * The marker that is selected.  Setting this property selects a particular
 * marker, showing an info window on it.  If this property is non-nil, setting
 * it to nil deselects the marker, hiding the info window.  This property is
 * observable using KVO.
 */
@property (nonatomic, strong) id<GMSMarker> selectedMarker;

/**
 * Controls whether the map is drawing traffic data, if available.  This is
 * subject to the availability of traffic data.  Defaults to NO.
 */
@property (nonatomic, assign, getter=isTrafficEnabled) BOOL trafficEnabled;

/**
 * Controls the type of map tiles that should be displayed.  Defaults to
 * kGMSTypeNormal.
 */
@property (nonatomic, assign) GMSMapViewType mapType;

/**
 * Gets the GMSUISettings object, which controls user interface settings for the
 * map.
 */
@property (nonatomic, readonly) GMSUISettings *settings;

/**
 * Builds and returns a GMSMapView, with a frame and camera target.
 */
+ (GMSMapView *)mapWithFrame:(CGRect)frame
                      camera:(GMSCameraPosition *)camera;

/**
 * Tells this map to power up its renderer.  This is optional- GMSMapView will
 * automatically invoke this method when added to a window.  It is safe to call
 * this method more than once.
 */
- (void)startRendering;

/**
 * Tells this map to power down its renderer, releasing its resources.  This is
 * optional- GMSMapView will automatically invoke this method when removed from
 * a window.  It is safe to call this method more than once.
 */
- (void)stopRendering;

/**
 * Animates the camera of this map to |cameraPosition|. During the animation,
 * retrieving the camera position through the camera property returns an
 * intermediate immutable GMSCameraPosition.
 *
 * The duration of this animation, and those below (animateToLocation:,
 * animateToZoom:, animateToBearing: and animateToViewingAngle:) is controlled
 * by Core Animation.
 */
- (void)animateToCameraPosition:(GMSCameraPosition *)cameraPosition;

/**
 * As animateToCamera:, but changes only the location of the camera (i.e., from
 * the current location to |location|).
 */
- (void)animateToLocation:(CLLocationCoordinate2D)location;

/**
 * As animateToCamera:, but changes only the zoom level of the camera. This
 * value is clamped by [kGMSMinZoomLevel, kGMSMaxZoomLevel].
 */
- (void)animateToZoom:(CGFloat)zoom;

/**
 * As animateToCamera:, but changes only the bearing of the camera (in degrees).
 * Zero indicates true north.
 */
- (void)animateToBearing:(CLLocationDirection)bearing;

/**
 * As animateToCamera:, but changes only the viewing angle of the camera (in
 * degrees). This value will be clamped to a minimum of zero (i.e., facing
 * straight down) and between 30 and 45 degrees towards the horizon, depending
 * on the relative closeness to the earth.
 */
- (void)animateToViewingAngle:(double)viewingAngle;

/**
 * Adds a marker to the map.  To remove the marker, call GMSMarker remove.
 *
 * @param options The marker options that configure the marker.
 * @return A marker object.
 */
- (id<GMSMarker>)addMarkerWithOptions:(GMSMarkerOptions *)options;

/**
 * Gets a list of all makers.
 *
 * @return A NSArray of the id<GMSMarker> instances currently on the map.
 */
- (NSArray *)markers;

/**
 * Adds a polyline to the map.  To remove the polyline, call GMSPolyline remove.
 *
 * @param options The polyline options that configure the polyline.
 * @return A polyline.
 */
- (id<GMSPolyline>)addPolylineWithOptions:(GMSPolylineOptions *)options;

/**
 * Gets a list of all polylines.
 *
 * @return A NSArray of the id<GMSPolyline> instances currently on the map.
 */
- (NSArray *)polylines;

/**
 * Adds a ground overlay to the map.
 *
 * @param options The ground overlay options that configure the ground overlay.
 * @return A ground overlay object.
 */
- (id<GMSGroundOverlay>)addGroundOverlayWithOptions:(GMSGroundOverlayOptions *)options;

/**
 * Gets a list of all ground overlays.
 *
 * @return A NSArray of the id<GMSGroundOverlay> instances currently on the map.
 */
- (NSArray *)groundOverlays;

/**
 * Clears all markup that has been added to the map, including markers,
 * polylines and ground overlays.  This will not clear the visible location dot
 * or reset the current mapType.
 */
- (void)clear;

@end

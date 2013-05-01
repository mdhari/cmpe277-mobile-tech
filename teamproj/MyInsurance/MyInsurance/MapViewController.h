//
//  MapViewController.h
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleMaps/GoogleMaps.h>
#import <CoreLocation/CoreLocation.h>

@interface MapViewController : UIViewController<UISearchBarDelegate,NSURLConnectionDelegate,CLLocationManagerDelegate>
{
    NSMutableData *responseData;
    GMSMapView *mapView;
    NSDictionary *dict;
    NSMutableArray *markers;
    GMSCoordinateBounds *bounds;
    CLLocationCoordinate2D userLocation;
    CLLocationManager *locationManager;
    CLLocation *location;
    
}
@property (strong,nonatomic) NSMutableData *responseData;
@property (strong,nonatomic) GMSMapView *mapView;
@property (strong,nonatomic) NSDictionary *dict;
@property (strong, nonatomic)NSMutableArray *markers;
@property (strong,nonatomic) GMSCoordinateBounds *bounds;
@property (nonatomic,readonly) CLLocationCoordinate2D userLocation;
@property (strong,nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CLLocation *location;

-(NSDictionary *) parseQueryString:(NSString *) urlString;
-(void) drawMarkers : (NSMutableArray *) array;
-(GMSCameraPosition *) cameraDisplayingAllVisibleMarkers;

@end

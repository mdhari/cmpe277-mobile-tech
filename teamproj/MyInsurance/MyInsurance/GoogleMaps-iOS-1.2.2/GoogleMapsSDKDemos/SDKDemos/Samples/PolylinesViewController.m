#import "PolylinesViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation PolylinesViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:0
                                                          longitude:-180
                                                               zoom:3];
  GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];

  // Create a 'normal' polyline.
  GMSPolyline *polyline = [[GMSPolyline alloc] init];
  GMSMutablePath *path = [GMSMutablePath path];
  [path addCoordinate:CLLocationCoordinate2DMake(37.772323, -122.214897)];
  [path addCoordinate:CLLocationCoordinate2DMake(21.291982, -157.821856)];
  [path addCoordinate:CLLocationCoordinate2DMake(-18.142599, 178.431)];
  [path addCoordinate:CLLocationCoordinate2DMake(-27.46758, 153.0278926)];
  polyline.path = path;
  polyline.strokeColor = [UIColor redColor];
  polyline.strokeWidth = 2.f;
  polyline.map = mapView;

  // Copy the previous polyline, change its color, and mark it as geodesic.
  polyline = [polyline copy];
  polyline.strokeColor = [UIColor greenColor];
  polyline.geodesic = YES;
  polyline.map = mapView;

  self.view = mapView;
}

@end
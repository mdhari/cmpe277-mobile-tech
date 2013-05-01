#import "GroundOverlayViewController.h"
#import <GoogleMaps/GoogleMaps.h>

@implementation GroundOverlayViewController {
  GMSGroundOverlay *overlay_;
}

- (void)viewDidLoad {
  [super viewDidLoad];

  CLLocationCoordinate2D newark = CLLocationCoordinate2DMake(40.742, -74.174);
  GMSCameraPosition *camera = [GMSCameraPosition cameraWithTarget:newark
                                                             zoom:12
                                                          bearing:0
                                                     viewingAngle:50];
  GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];

  GMSGroundOverlay *groundOverlay = [[GMSGroundOverlay alloc] init];
  // Image from http://www.lib.utexas.edu/maps/historical/newark_nj_1922.jpg
  groundOverlay.icon = [UIImage imageNamed:@"newark_nj_1922.jpg"];
  groundOverlay.position = newark;
  groundOverlay.bearing = 0;
  groundOverlay.zoomLevel = 13.6;
  groundOverlay.map = mapView;

  self.view = mapView;
}

@end

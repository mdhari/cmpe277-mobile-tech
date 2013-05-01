//
//  MapViewController.m
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "MapViewController.h"
#import <GoogleMaps/GoogleMaps.h>
#import "Location.h"
#import <MapKit/MapKit.h>

@interface MapViewController ()

@end

@implementation MapViewController

@synthesize responseData,mapView,dict,markers,bounds,userLocation;
@synthesize locationManager,location;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Updating recent locations
    self.locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate =self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = kCLDistanceFilterNone;
    [self.locationManager startUpdatingLocation];
    
    self.location = [[CLLocation alloc] init];
    
    //Inserting a Search Bar
    UISearchBar *search = [[UISearchBar alloc] init];
    [search setTintColor:[UIColor colorWithRed:233.0/255.0
                                         green:233.0/255.0
                                          blue:233.0/255.0
                                         alpha:1.0]];
    search.frame = CGRectMake(0, 0, 320, 50);
    search.delegate = self;
    search.showsBookmarkButton=YES;
    [self.view addSubview:search];
    
    // connecting with the url
    NSURL *url = [NSURL URLWithString:@"https://maps.googleapis.com/maps/api/place/search/json?"];
    NSString * urlString = [url absoluteString];
    //keyword=coffee&location=37.787930,-122.4074990&radius=5000&sensor=false&key=AIzaSyCcC9pmri9XGOgyhjoHQq37cmcbfhjfghf6bBZe80
    NSString *keyword=@"bodyshop";
    NSString * location =@"37.787930,-122.4074990";
    int radius=1000;
    NSString *sensor=@"false";
    NSString *key=@"AIzaSyBeTmoeydWQFwqU4Yc92LkjyrS46I-I9Oc";
    NSString *newURL = [urlString stringByAppendingFormat:@"keyword=%@&location=%@&radius=%d&sensor=%@&key=%@",keyword,location,radius,sensor,key];
    NSLog(@"%@",newURL);
    NSURL *aURL = [NSURL URLWithString:newURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aURL];
    [request setHTTPMethod:@"GET"];
    [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    
    
}
- (void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    self.location =locations.lastObject;
    NSLog(@"%0.8f",self.location.coordinate.latitude);
    NSLog(@"%0.8f",self.location.coordinate.longitude);
    
}

-(void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *)response{
    responseData = [[NSMutableData alloc]init];
    
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSString *geometry;
    NSMutableArray *arrayLocation = [[NSMutableArray alloc]init];
    [responseData appendData:data];
    NSString *json = [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
    NSError *error;
    dict = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:&error];
    NSDictionary *resultDictionary = [dict objectForKey:@"results"];
    
    
    for(NSDictionary *dt in resultDictionary){
        geometry = [dt objectForKey:@"geometry"];
        NSString *latitudeString = [geometry valueForKeyPath:@"location.lat"];
        NSString *longitudeString =[geometry valueForKeyPath:@"location.lng"];
        Location *loc = [[Location alloc] init];
        loc.latitude = [latitudeString doubleValue];
        loc.longitude = [longitudeString doubleValue];
        loc.name =[dt objectForKey:@"name"];
        [arrayLocation addObject:loc];
        CLLocationCoordinate2D position = CLLocationCoordinate2DMake([latitudeString doubleValue], [longitudeString doubleValue]);
        GMSMarker *mark = [GMSMarker markerWithPosition:position];
        mark.title = loc.name;
        [markers addObject:mark];
        NSLog(@"%@",geometry);
    }
    
    //GMSCameraPosition *camera =[self cameraDisplayingAllVisibleMarkers];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:self.location.coordinate.latitude longitude:self.location.coordinate.longitude zoom:14];
    mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    self.view = mapView;
    [self.mapView animateToCameraPosition:camera];
    mapView.myLocationEnabled=YES;
    mapView.settings.myLocationButton = YES;
    [self drawMarkers:arrayLocation];
    
}

-(void) drawMarkers:(NSMutableArray *)array{
    
    double sjsuLatitude = 37.785834;
    double sjsuLongitude =  -122.40641700;
    CLLocationCoordinate2D sjsuCoord = CLLocationCoordinate2DMake(sjsuLatitude,sjsuLongitude);
    GMSMarker *sjsuMarker =[[GMSMarker alloc]init];
    [sjsuMarker setPosition: sjsuCoord];
    [sjsuMarker setTitle:@"SJSU"];
    sjsuMarker.icon = [UIImage imageNamed:@"car1.png"];
    [sjsuMarker setMap:self.mapView];
    
    for(int i =0; i< [array count];i++){
        Location *loc = [array objectAtIndex:i];
        double annotationLat = loc.latitude;
        double annotationLng = loc.longitude;
        CLLocationCoordinate2D coord = {.latitude = annotationLat ,.longitude=annotationLng};
        GMSMarker *marker = [[GMSMarker alloc]init];
        [marker setPosition:coord];
        [marker setTitle:loc.name];
        marker.icon = [UIImage imageNamed:@"car1.png"];
        [marker setMap:self.mapView];
        
    }//end of for loop
    //37.336122, -121.880465
    
    
}

-(GMSCameraPosition *)cameraDisplayingAllVisibleMarkers{
    
    if(1==[self.markers count]){
        
        GMSMarker *mark = [self.markers objectAtIndex:0];
        return [GMSCameraPosition cameraWithLatitude:mark.position.latitude longitude:mark.position.longitude zoom:21.0f];
    }
    else if([self.markers count] >= 2){
        GMSMarker *marker1 = [self.markers objectAtIndex:0];
        GMSMarker *marker2 = [self.markers objectAtIndex:1];
        
        bounds = [[GMSCoordinateBounds alloc] initWithCoordinate:marker1.position coordinate:marker2.position];
        
        for(NSUInteger i=2 ; i< [self.markers count];i++){
            
            GMSMarker *marki = [self.markers objectAtIndex:i];
            if(marki.position.latitude !=0.0f && marki.position.longitude!=0.0f){
                
                bounds = [bounds includingCoordinate:marki.position];
            }
        }
        
        //CLLocationCoordinate2D southWest = bounds.southWest;
        //CLLocationCoordinate2D northEast = bounds.northEast;
        //float mapViewHeight = [UIScreen mainScreen].applicationFrame.size.height;
        //float mapViewWidth = [UIScreen mainScreen].applicationFrame.size.width;
        //MKMapPoint point1 = MKMapPointForCoordinate(southWest);
        //MKMapPoint point2 = MKMapPointForCoordinate(northEast);
        
        //MKMapPoint centerPoint = MKMapPointMake((point1.x + point2.x) / 2.0f,
        //                                      (point1.y + point2.y) / 2.0f);
        //CLLocationCoordinate2D centerLocation = MKCoordinateForMapPoint(centerPoint);
        //double mapScaleWidth = mapViewWidth / fabs(point2.x - point1.x);
        //double mapScaleHeight = mapViewHeight / fabs(point2.y - point1.y);
        //double mapScale = MIN(mapScaleWidth, mapScaleHeight);
        //double zoomLevel = (20.0f + log2(mapScale)) - 1.0f;
        //zoomLevel = (zoomLevel < 2.0f) ? 2.0f : zoomLevel;
        //zoomLevel = (zoomLevel > 21.0f) ? 21.0f : zoomLevel;
        
        CGPoint markerBoundTopLeft = [self.mapView.projection pointForCoordinate:CLLocationCoordinate2DMake(self.bounds.northEast.latitude,self.bounds.southWest.longitude )];
        CGPoint markerBoundBottomRight = [self.mapView.projection pointForCoordinate:CLLocationCoordinate2DMake(self.bounds.southWest.latitude, self.bounds.northEast.longitude)];
        
        CGPoint currentLocation = [self.mapView.projection pointForCoordinate:self.location.coordinate];
        CGPoint markerBoundsCurrentLocationMaxDelta =
        
        CGPointMake(MAX(fabs(currentLocation.x - markerBoundTopLeft.x),fabs(currentLocation.x-markerBoundBottomRight.x)), MAX(fabs(currentLocation.y - markerBoundTopLeft.y),fabs(currentLocation.y-markerBoundBottomRight.y)));
        
        CGSize centeredMarkerBoundsSize = CGSizeMake(2.0 * markerBoundsCurrentLocationMaxDelta.x, 2.0 * markerBoundsCurrentLocationMaxDelta.y);
        
        CGSize insetViewBoundsSize = CGSizeMake(self.mapView.bounds.size.width, self.mapView.bounds.size.height );
        
        CGFloat x1;
        CGFloat x2;
        
        // decide which axis to calculate the zoom level with by comparing the width/height ratios
        if (centeredMarkerBoundsSize.width / centeredMarkerBoundsSize.height > insetViewBoundsSize.width / insetViewBoundsSize.height)
        {
            x1 = centeredMarkerBoundsSize.width;
            x2 = insetViewBoundsSize.width;
        }
        else
        {
            x1 = centeredMarkerBoundsSize.height;
            x2 = insetViewBoundsSize.height;
        }
        
        CGFloat zoom = log2(x2 * pow(2, self.mapView.camera.zoom) / x1);
        
        
        return [GMSCameraPosition cameraWithTarget:self.location.coordinate zoom:zoom];
    }
    return nil;
    
}



@end

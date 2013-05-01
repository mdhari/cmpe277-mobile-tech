//
//  Location.m
//  MyInsurance
//
//  Created by Rahul Mehta on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "Location.h"

@implementation Location
@synthesize latitude,longitude,name;

@end

/*

//GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:37.79 longitude:-122.40 zoom:10];
//mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
//mapView.myLocationEnabled=YES;
//self.view = mapView;
//mapView.settings.myLocationButton = YES;



for(int i =0; i< [array count];i++){
    Location *loc = [array objectAtIndex:i];
    double annotationLat = loc.latitude;
    double annotationLng = loc.longitude;
    
    //GMSMarker *marker = [[GMSMarker alloc]init];
    //marker.position = CLLocationCoordinate2DMake(loc.latitude, loc.longitude);
    //marker.title = loc.name;
    //marker.map=mapView;
    
}//end of for loop

//[self setMapRegionForMinLat:minLatitude minLong:minLongitude maxLat:maxLatitude maxLong:maxLongitude];

}

-(void) setMapRegionForMinLat:(double)minLatitude
 minLong:(double)minLongitude
 maxLat:(double)maxLatitude
 maxLong:(double)maxLongitude{
 
 GMSCoordinateBounds *bounds = [[GMSCoordinateBounds alloc] initWithRegion:self.mapView.projection.visibleRegion];
 CLLocationCoordinate2D northEast = bounds.northEast;
 CLLocationCoordinate2D northWest = CLLocationCoordinate2DMake(bounds.northEast.latitude,bounds.southWest.longitude );
 CLLocationCoordinate2D southEast = CLLocationCoordinate2DMake(bounds.southWest.latitude, bounds.northEast.longitude);
 CLLocationCoordinate2D southWest = bounds.southWest;
 
 }*/

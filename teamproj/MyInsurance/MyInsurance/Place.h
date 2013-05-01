//
//  Place.h
//  MyInsurance
//
//  Created by Rahul Mehta on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>
#import"Geometry.h"

@interface Place : NSObject
{
    NSString *id;
    NSString *name;
    NSString *vicinity;
    NSString *icon;
    Geometry *geometry;
    
}

@property NSString *id;
@property NSString *name;
@property NSString *vicinity;
@property NSString *icon;
@property Geometry *geometry;

@end

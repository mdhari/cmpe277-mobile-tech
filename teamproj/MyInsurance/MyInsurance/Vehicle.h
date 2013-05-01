//
//  Vehicle.h
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Vehicle : NSObject

@property(strong,nonatomic) NSString *make;
@property(strong,nonatomic) NSString *model;
@property(nonatomic) int year;
@property(strong,nonatomic) NSString *vin;

@end

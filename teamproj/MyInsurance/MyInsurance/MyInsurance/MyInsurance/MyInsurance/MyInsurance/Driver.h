//
//  Driver.h
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Driver : NSObject

@property(strong,nonatomic) NSString *fullName;
@property(strong,nonatomic) NSString *licenseId;
@property(strong,nonatomic) NSString *address1;
@property(strong,nonatomic) NSString *address2;
@property(strong,nonatomic) NSString *city;
@property(strong,nonatomic) NSString *state;
@property(nonatomic) int zipcode;
@property(strong,nonatomic) NSDate *dob;

@end

//
//  Policy.h
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Policy : NSObject

@property(strong,nonatomic) NSMutableArray *drivers;
@property(strong,nonatomic) NSMutableArray *vehicles;

@end

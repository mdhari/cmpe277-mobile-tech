//
//  Policy.m
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "Policy.h"

@implementation Policy

-(id)init{
    self = [super init];
    
    if(self){
        self.drivers = [[NSMutableArray alloc] init];
        self.vehicles = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end

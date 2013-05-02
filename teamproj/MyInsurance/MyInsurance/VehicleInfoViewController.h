//
//  VehicleInfoViewController.h
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *vin;
@property (strong, nonatomic) IBOutlet UILabel *make;
@property (strong, nonatomic) IBOutlet UILabel *model;
@property (strong, nonatomic) IBOutlet UILabel *year;

@property(strong,nonatomic) NSString *vinText;
@property(strong,nonatomic) NSString *makeText;
@property(strong,nonatomic) NSString *modelText;
@property(strong,nonatomic) NSString *yearText;

@end

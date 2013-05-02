//
//  DriverInfoViewController.h
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DriverInfoViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *licenseID;

@property (strong, nonatomic) IBOutlet UILabel *fullName;

@property (strong, nonatomic) IBOutlet UILabel *address;

@property (strong, nonatomic) IBOutlet UILabel *city;
@property (strong, nonatomic) IBOutlet UILabel *state;

@property (strong, nonatomic) IBOutlet UILabel *zipCode;
@property (strong, nonatomic) IBOutlet UILabel *dob;

@property(strong,nonatomic) NSString *licenseIDText;
@property(strong,nonatomic) NSString *fullNameText;
@property(strong,nonatomic) NSString *addressText;
@property(strong,nonatomic) NSString *cityText;
@property(strong,nonatomic) NSString *stateText;
@property(strong,nonatomic) NSString *zipcodeText;
@property(strong,nonatomic) NSString *dobText;
@end

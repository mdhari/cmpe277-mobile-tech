//
//  VehicleConfirmationViewController.h
//  MyInsurance
//
//  Created by Nazneen Ayubkhan Pathan on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VehicleConfirmationViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *vintext;
@property (weak, nonatomic) IBOutlet UITextField *makeField;
@property (weak, nonatomic) IBOutlet UITextField *modelField;
@property (weak, nonatomic) IBOutlet UITextField *yearField;
@property (strong,nonatomic) NSMutableData *responseData;

@property (strong, nonatomic) NSString *vin;
- (IBAction)addVehicle:(id)sender;

@end

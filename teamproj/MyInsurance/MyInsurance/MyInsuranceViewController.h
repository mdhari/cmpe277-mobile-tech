//
//  MyInsuranceViewController.h
//  MyInsurance
//
//  Created by Michael Hari, Shariq on 4/17/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyInsuranceViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *emailTxtField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTxtField;

- (IBAction)Submit:(id)sender;

- (IBAction)Cancel:(id)sender;
@end

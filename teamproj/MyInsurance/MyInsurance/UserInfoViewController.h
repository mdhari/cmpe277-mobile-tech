//
//  UserInfoViewController.h
//  MyInsurance
//
//  Created by Shariq Iqbal on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *LicenseId;
@property (weak, nonatomic) IBOutlet UITextField *FullName;
@property (weak, nonatomic) IBOutlet UITextField *Addr1;
@property (weak, nonatomic) IBOutlet UITextField *Addr2;
@property (weak, nonatomic) IBOutlet UITextField *City;
@property (weak, nonatomic) IBOutlet UITextField *State;
@property (weak, nonatomic) IBOutlet UITextField *Zip;
@property (weak, nonatomic) IBOutlet UITextField *DOB;

- (IBAction)submit:(id)sender;





@end

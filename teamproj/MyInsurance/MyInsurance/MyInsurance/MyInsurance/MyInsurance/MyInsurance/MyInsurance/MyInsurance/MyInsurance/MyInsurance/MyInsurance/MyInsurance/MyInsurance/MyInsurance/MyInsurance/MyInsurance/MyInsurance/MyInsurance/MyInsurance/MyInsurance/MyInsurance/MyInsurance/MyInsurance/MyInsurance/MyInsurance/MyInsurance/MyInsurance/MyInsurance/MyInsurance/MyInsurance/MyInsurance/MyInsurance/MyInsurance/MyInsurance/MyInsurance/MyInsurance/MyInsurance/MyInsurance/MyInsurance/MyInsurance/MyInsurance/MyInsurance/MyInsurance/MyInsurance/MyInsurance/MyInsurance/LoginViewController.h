//
//  LoginViewController.h
//  MyInsurance
//
//  Created by Shariq Iqbal on 4/27/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<NSXMLParserDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameTxtField;
@property (nonatomic) BOOL policyNumElementFound;
@property (weak, nonatomic) IBOutlet UITextField *passwordTxtField;
- (IBAction)login:(id)sender;
@end

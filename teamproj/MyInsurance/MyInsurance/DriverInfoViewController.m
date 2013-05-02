//
//  DriverInfoViewController.m
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "DriverInfoViewController.h"
#import "Driver.h"

@interface DriverInfoViewController ()

@end

@implementation DriverInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //NSLog(@"Vin is: %@",self.vinText);
    self.licenseID.text=self.licenseIDText;
    self.fullName.text=self.fullNameText;
    self.address.text=self.addressText;
    self.city.text=self.cityText;
    self.state.text=self.stateText;
    self.zipCode.text=self.zipcodeText;
    self.dob.text=self.dobText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

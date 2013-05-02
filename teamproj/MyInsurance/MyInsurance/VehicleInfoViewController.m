//
//  VehicleInfoViewController.m
//  MyInsurance
//
//  Created by Michael Hari on 5/1/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "VehicleInfoViewController.h"

@interface VehicleInfoViewController ()

@end

@implementation VehicleInfoViewController

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
    NSLog(@"Vin is: %@",self.vinText);
    self.vin.text=self.vinText;
    self.make.text=self.makeText;
    self.model.text=self.modelText;
    self.year.text=self.yearText;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  VehicleConfirmationViewController.m
//  MyInsurance
//
//  Created by Nazneen Ayubkhan Pathan on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "VehicleConfirmationViewController.h"
#import "Properties.h"

@interface VehicleConfirmationViewController ()

@end

@implementation VehicleConfirmationViewController
@synthesize vin,vintext;
@synthesize modelField,makeField,yearField,responseData;
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
    self.vintext.text = [NSString stringWithFormat:@"%@",self.vin];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) displayAlert:(NSString *)_message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Information" message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)addVehicle:(id)sender {
   // curl -X POST "http://ec2-50-112-209-82.us-west-2.compute.amazonaws.com:8080/MyInsuranceWS/rest/vehicle?make=ford&model=MustangGT&year=2011&vin=1234567890qwertyz&policyNumber=1543186046"
    NSLog(@"vin:%@",self.vin);
    NSURL *url = [NSURL URLWithString:BASE_WEBSERVICE_URL];
    NSString   *urlString = [url absoluteString];
    NSString *make = self.makeField.text;
    NSString *model = self.modelField.text;
    NSString  *year = self.yearField.text;
    NSString *policyNumber = [[NSUserDefaults standardUserDefaults] valueForKey:@"policyNumber"];
    NSString *newUrl = [urlString stringByAppendingFormat:@"/vehicle?make=%@&model=%@&year=%@&vin=%@&policyNumber=%@",make,model,year,self.vintext.text,policyNumber];
    NSURL *aurl = [NSURL URLWithString:newUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:aurl];
    [request setHTTPMethod:@"POST"];
    NSLog(@"url:%@",newUrl);
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"urlResponse:%d",urlResponse.statusCode);
    if(urlResponse.statusCode!=200){
        [self displayAlert:@"Error from Webservice"];
    }else{
        [self displayAlert:@"Successfully added this vehicle to your policy. You can find it under View Policy on the Main Menu!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}




@end

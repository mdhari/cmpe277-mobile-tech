//
//  UserInfoViewController.m
//  MyInsurance
//
//  Created by Shariq Iqbal on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "UserInfoViewController.h"
#import "Properties.h"

@interface UserInfoViewController ()

@end

@implementation UserInfoViewController

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

}

// Display the picker instead of a keyboard



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    
}

-(void) displayAlert:(NSString *)_message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Information" message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}
    

- (IBAction)submit:(id)sender {
   
    //curl -X POST "http://ec2-50-112-209-82.us-west-2.compute.amazonaws.com:8080/MyInsuranceWS/rest/driver?licenseId=D2345151&fullName=Michael%20David%20Hari&address1=123%20Fake%20Street&city=San%20Leandro&state=CA&zipcode=94579&dob=12/12/2013&policyNumber=1543186046
    
    
     NSString *webserviceURL = [NSString stringWithFormat:@"%@/driver?licenseId=%@&fullName=%@&address1=%@&city=%@&state=%@&zipcode=%@&dob=%@&policyNumber=%@",BASE_WEBSERVICE_URL,self.LicenseId.text, self.FullName.text, self.Addr1.text, self.City.text, self.State.text, self.Zip.text, self.DOB.text,[[NSUserDefaults standardUserDefaults] valueForKey:@"policyNumber"]];
    webserviceURL = [webserviceURL stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    NSURL *url=[[NSURL alloc]initWithString:webserviceURL];

    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    NSLog(@"url:%@",webserviceURL);
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"urlResponse:%d",urlResponse.statusCode);
    if(urlResponse.statusCode!=200){
        [self displayAlert:@"Error from webservice"];
    }else{
        [self displayAlert:@"Successfully added a driver to your policy! You can find it under View Policy on the Main Menu!"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end

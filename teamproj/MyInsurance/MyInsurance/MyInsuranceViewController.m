//
//  MyInsuranceViewController.m
//  MyInsurance
//
//  Created by Michael Hari, Rahul, Shariq on 4/17/13.
// 
//  Copyright (c) 2013 San Jose State University. All rights reserved.
// App uses d09a17 background

#import "MyInsuranceViewController.h"
#import "Properties.h"

@interface MyInsuranceViewController ()

@end

@implementation MyInsuranceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
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

- (IBAction)Submit:(id)sender {
    NSString *webserviceURL = [NSString stringWithFormat:@"%@/register?email=%@&password=%@",BASE_WEBSERVICE_URL,self.emailTxtField.text,self.passwordTxtField.text];
    
    NSURL *url=[[NSURL alloc]initWithString:webserviceURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"urlResponse:%d",urlResponse.statusCode);
    if(urlResponse.statusCode!=200){
        [self displayAlert:@"Error from authentication server"];
    }else{
        [self displayAlert:@"Success! You can now use your login!"];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)Cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end

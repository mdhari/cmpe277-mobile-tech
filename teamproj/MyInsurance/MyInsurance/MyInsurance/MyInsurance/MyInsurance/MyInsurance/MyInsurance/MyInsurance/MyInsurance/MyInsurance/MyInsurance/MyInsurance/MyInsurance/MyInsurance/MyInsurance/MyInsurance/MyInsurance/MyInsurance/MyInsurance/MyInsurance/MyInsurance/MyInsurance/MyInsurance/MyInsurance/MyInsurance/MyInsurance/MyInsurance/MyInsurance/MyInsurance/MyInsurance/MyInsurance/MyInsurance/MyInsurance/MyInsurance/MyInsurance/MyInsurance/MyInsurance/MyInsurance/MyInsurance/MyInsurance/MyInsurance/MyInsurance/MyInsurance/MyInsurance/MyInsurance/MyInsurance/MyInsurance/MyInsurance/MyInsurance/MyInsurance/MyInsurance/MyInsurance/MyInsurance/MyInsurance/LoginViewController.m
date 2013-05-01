//
//  LoginViewController.m
//  MyInsurance
//
//  Created by Shariq Iqbal on 4/27/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "LoginViewController.h"
#import "Properties.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    if ([elementName isEqualToString:@"policy_number"]) {
        self.policyNumElementFound = YES;
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    if (self.policyNumElementFound) {
        NSLog(@"policy_num:%@",string);
        NSUserDefaults *nsUserDefaults = [NSUserDefaults standardUserDefaults];
        [nsUserDefaults setValue:string forKey:@"policyNumber"];
        [nsUserDefaults synchronize];
        self.policyNumElementFound = NO;
    }
}

-(void) displayAlert:(NSString *)_message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Information" message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

- (IBAction)login:(id)sender {
    self.policyNumElementFound=NO;
    NSString *webserviceURL = [NSString stringWithFormat:@"%@/checkcredentials?username=%@&password=%@",BASE_WEBSERVICE_URL,self.usernameTxtField.text,self.passwordTxtField.text];
    
    NSURL *url=[[NSURL alloc]initWithString:webserviceURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"urlResponse:%d",urlResponse.statusCode);
    if(urlResponse.statusCode!=200){
        [self displayAlert:@"Error from authentication server"];
    }else{
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        xmlParser.delegate=self;
        [xmlParser parse];
        NSString *val = [[NSUserDefaults standardUserDefaults] valueForKey:@"policyNumber"];
        if(![val isEqualToString:@"0"]){
            self.passwordTxtField.text=@"";
            [self performSegueWithIdentifier:@"loginSegue" sender:self];
        }
        else
            [self displayAlert:@"Username or Password is incorrect"];
    }
}


@end

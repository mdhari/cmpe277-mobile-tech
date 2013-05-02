//
//  Policy.m
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "Policy.h"
#import "Properties.h"

@implementation Policy

-(id)init{
    self = [super init];
    
    if(self){
        self.drivers = [[NSMutableArray alloc] init];
        self.vehicles = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void) displayAlert:(NSString *)_message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Information" message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

//-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
//   attributes: (NSDictionary *)attributeDict{
//    if ([elementName isEqualToString:@"policy_number"]) {
//        self.policyNumElementFound = YES;
//    }
//    
//}
//
//- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
//    
//    if (self.policyNumElementFound) {
//        NSLog(@"policy_num:%@",string);
//        NSUserDefaults *nsUserDefaults = [NSUserDefaults standardUserDefaults];
//        [nsUserDefaults setValue:string forKey:@"policyNumber"];
//        [nsUserDefaults synchronize];
//        self.policyNumElementFound = NO;
//    }
//}

-(void)getDataFromWebService{
    
    
    NSString *webserviceURL = [NSString stringWithFormat:@"%@/policy?policyNumber=%@",BASE_WEBSERVICE_URL,[[NSUserDefaults standardUserDefaults] valueForKey:@"policyNumber"]];
    
    NSURL *url=[[NSURL alloc]initWithString:webserviceURL];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setValue:@"application/xml" forHTTPHeaderField:@"Content-Type"];
    
    NSHTTPURLResponse* urlResponse = nil;
    NSError *error = [[NSError alloc] init];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
    NSLog(@"urlResponse:%d",urlResponse.statusCode);
    if(urlResponse.statusCode!=200){
        [self displayAlert:@"Error from authentication server"];
    }else{//success
        NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:data];
        xmlParser.delegate=self;
        [xmlParser parse];
    }
    
    
    
    
}

@end

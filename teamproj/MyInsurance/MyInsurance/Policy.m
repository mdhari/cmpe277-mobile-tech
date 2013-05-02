//
//  Policy.m
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "Policy.h"
#import "Properties.h"
#import "Driver.h"

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

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *) namespaceURI qualifiedName:(NSString *)qName
   attributes: (NSDictionary *)attributeDict{
    //<driver>
    //<address1>123 Fake Street</address1>
    //<city>San Leandro</city>
    //<dob>12/12/2013</dob>
    //<full_name>Michael David Hari</full_name>
    //<license_id>D2345151</license_id>
    //<state>CA</state>
    //<zipcode>94579</zipcode>
    //</driver>
    if([elementName isEqualToString:@"driver"]){
        self.inDriverTag=YES;
        self.driver = [[Driver alloc]init];
    }
    if ([elementName isEqualToString:@"address1"]) {
        self.inAddr1Tag=YES;
    }
    
    if([elementName isEqualToString:@"city"]){
        self.inCityTag=YES;
    }
    
    if([elementName isEqualToString:@"dob"]){
        self.inDOBTag=YES;
    }

    if([elementName isEqualToString:@"full_name"]){
        self.inFullNameTag=YES;
    }

if([elementName isEqualToString:@"license_id"]){
    self.inLicenseIdTag=YES;
    
}

if([elementName isEqualToString:@"state"]){
    self.inStateTag=YES;
    
}

if([elementName isEqualToString:@"zipcode"]){
    self.inZipcodeTag=YES;
    
}

}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"driver"]){
        [self.drivers addObject:self.driver];
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    if(self.inAddr1Tag)
        self.driver.address1=string;
    
    
    if(self.inDOBTag)
        self.driver.dob=string;
    
    if(self.inCityTag)
        self.driver.city=string;
        
    if(self.inFullNameTag)
        self.driver.fullName=string;
    
    if(self.inLicenseIdTag)
        self.driver.licenseId=string;
    
    if(self.inStateTag)
        self.driver.state=string;
        
    if(self.inZipcodeTag)
        self.driver.zipcode=string;
    
}

-(void)getDataFromWebService{
    
//    self.isAddr1Tag=NO;
//    self.isCityTag=NO;
//    self.isFullNameTag=NO;
//    self.isLicenseIdTag=NO;
//    self.isStateTag=NO;
//    self.isZipcodeTag=NO;
    
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

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
#import "Vehicle.h"

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
    if([elementName isEqualToString:@"vehicle"]){
        self.inVehicleTAG=YES;
        self.vehicle = [[Vehicle alloc] init];
    }

    if([elementName isEqualToString:@"make"]){
        self.inMakeTAG=YES;
    }
    
    if([elementName isEqualToString:@"model"]){
        self.inModelTAG=YES;
    }
    if([elementName isEqualToString:@"vin"]){
        self.inVinTAG=YES;
    }
    if([elementName isEqualToString:@"year"]){
        self.inYearTAG=YES;
    }
    
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    
    if([elementName isEqualToString:@"driver"]){
        [self.drivers addObject:self.driver];
        self.inDriverTag=NO;
    }
    
    if ([elementName isEqualToString:@"address1"]) {
        self.inAddr1Tag=NO;
    }
    
    if([elementName isEqualToString:@"city"]){
        self.inCityTag=NO;
    }
    
    if([elementName isEqualToString:@"dob"]){
        self.inDOBTag=NO;
    }
    
    if([elementName isEqualToString:@"full_name"]){
        self.inFullNameTag=NO;
    }
    
    if([elementName isEqualToString:@"license_id"]){
        self.inLicenseIdTag=NO;
        
    }
    
    if([elementName isEqualToString:@"state"]){
        self.inStateTag=NO;
        
    }
    
    if([elementName isEqualToString:@"zipcode"]){
        self.inZipcodeTag=NO;
        
    }
    
    if([elementName isEqualToString:@"vehicle"]){
        [self.vehicles addObject:self.vehicle];
        self.inVehicleTAG=NO;
    }
    
    if ([elementName isEqualToString:@"make"]) {
        self.inMakeTAG=NO;
    }
    
    if([elementName isEqualToString:@"model"]){
        self.inModelTAG=NO;
    }
    
    if([elementName isEqualToString:@"vin"]){
        self.inVinTAG=NO;
    }
    
    if([elementName isEqualToString:@"year"]){
        self.inYearTAG=NO;
    }
}


- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //<driver>
    //<address1>123 Fake Street</address1>
    //<city>San Leandro</city>
    //<dob>12/12/2013</dob>
    //<full_name>Michael David Hari</full_name>
    //<license_id>D2345151</license_id>
    //<state>CA</state>
    //<zipcode>94579</zipcode>
    //</driver>
    if(self.inAddr1Tag)
        self.driver.address1=string;
    
    
    if(self.inDOBTag)
        self.driver.dob=string;
    
    if(self.inCityTag)
        self.driver.city=string;
        
    if(self.inFullNameTag){
        self.driver.fullName=string;
    }
    
    if(self.inLicenseIdTag)
        self.driver.licenseId=string;
    
    if(self.inStateTag)
        self.driver.state=string;
        
    if(self.inZipcodeTag)
        self.driver.zipcode=[string intValue];
    
    if(self.inMakeTAG)
        self.vehicle.make=string;
    
    if(self.inModelTAG)
        self.vehicle.model=string;
    
    if(self.inVinTAG)
        self.vehicle.vin=string;
    
    if(self.inYearTAG)
        self.vehicle.year=[string intValue];
    
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
    NSLog(@"url:%@",webserviceURL);
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
        for(Driver *aDriver in self.drivers){
            NSLog(@"%@ %@ %@ %@",aDriver.fullName,aDriver.dob,aDriver.state,aDriver.city);
        }
    }
    
    
    
    
}

@end

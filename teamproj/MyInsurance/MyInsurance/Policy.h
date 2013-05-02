//
//  Policy.h
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Policy : NSObject<NSXMLParserDelegate>

@property(strong,nonatomic) NSMutableArray *drivers;
@property(strong,nonatomic) NSMutableArray *vehicles;

//<driver>
//<address1>123 Fake Street</address1>
//<city>San Leandro</city>
//<dob>12/12/2013</dob>
//<full_name>Michael David Hari</full_name>
//<license_id>D2345151</license_id>
//<state>CA</state>
//<zipcode>94579</zipcode>
//</driver>

//@property(nonatomic) BOOL

-(void)getDataFromWebService;

@end

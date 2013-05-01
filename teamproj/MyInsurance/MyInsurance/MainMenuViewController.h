//
//  MainMenuViewController.h
//  MyInsurance
//
//  Created by Nazneen Ayubkhan Pathan on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZBarSDK.h"

@interface MainMenuViewController : UITableViewController<ZBarReaderDelegate>

@property(strong,nonatomic) NSString *vin;

@end

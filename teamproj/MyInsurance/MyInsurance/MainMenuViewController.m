//
//  MainMenuViewController.m
//  MyInsurance
//
//  Created by Nazneen Ayubkhan Pathan on 4/28/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "MainMenuViewController.h"
#import "ZBarSDK.h"
#import "VehicleConfirmationViewController.h"
#import "Properties.h"

@interface MainMenuViewController ()

@end

@implementation MainMenuViewController
@synthesize vin;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 1){ //scan pressed
        ZBarReaderViewController *reader = [ZBarReaderViewController new];
        reader.readerDelegate = self;
        reader.supportedOrientationsMask = ZBarOrientationMaskAll;
        
        ZBarImageScanner *scanner = reader.scanner;
        // TODO: (optional) additional reader configuration here
        
        // EXAMPLE: disable rarely used I2/5 to improve performance
        [scanner setSymbology: 0
                       config: ZBAR_CFG_ENABLE
                           to: 0];
        [scanner setSymbology: ZBAR_CODE39
                       config: ZBAR_CFG_ENABLE
                           to: 1];
        
        // present and release the controller
        //[self presentModalViewController: reader animated: YES];
        [self presentViewController:reader animated:YES completion:nil];
    }else if(indexPath.row == 3){
        
        NSString *webserviceURL = [NSString stringWithFormat:@"%@/insurancecard?policyNumber=%@",BASE_WEBSERVICE_URL,[[NSUserDefaults standardUserDefaults] valueForKey:@"policyNumber"]];
        
        NSURL *url=[[NSURL alloc]initWithString:webserviceURL];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];

        NSLog(@"url:%@",webserviceURL);
        NSHTTPURLResponse* urlResponse = nil;
        NSError *error = [[NSError alloc] init];
        [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];
        NSLog(@"urlResponse:%d",urlResponse.statusCode);
        if(urlResponse.statusCode!=200){
            [self displayAlert:@"Error from authentication server"];
        }else{
            [self displayAlert:@"Email sent!"];
        }
    }
}

-(void) displayAlert:(NSString *)_message{
    
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Information" message:_message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
}

#pragma mark - ZBarReaderDelegateMethods

- (void) imagePickerController: (UIImagePickerController*) reader
 didFinishPickingMediaWithInfo: (NSDictionary*) info
{
    // ADD: get the decode results
    id<NSFastEnumeration> results =
    [info objectForKey: ZBarReaderControllerResults];
    ZBarSymbol *symbol = nil;
    for(symbol in results)
        // EXAMPLE: just grab the first barcode
        break;
    NSLog(@"VIN: %@",symbol.data);
    
    self.vin = symbol.data;
    //    // EXAMPLE: do something useful with the barcode data
    //    resultText.text = symbol.data;
    //
    //    // EXAMPLE: do something useful with the barcode image
    //    resultImage.image =
    //    [info objectForKey: UIImagePickerControllerOriginalImage];
    
    // ADD: dismiss the controller (NB dismiss from the *reader*!)
    //[reader dismissModalViewControllerAnimated: YES];
    [reader dismissViewControllerAnimated:YES completion:nil];
    
    [self performSegueWithIdentifier: @"CheckVehicleToVehicleConfirmSegue" sender: self];
}

// This will get called too before the view appears
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSLog(@"prepareForSegue called!");
    
    if ([[segue identifier] isEqualToString:@"CheckVehicleToVehicleConfirmSegue"]) {
        
        // Get destination view
        VehicleConfirmationViewController *vc = [segue destinationViewController];
        
        NSLog(@"self.vin is: %@",self.vin);
        
        vc.vin = self.vin; // pass the VIN
        [segue.destinationViewController setVin:vc.vin];
        
        
        //        // Get button tag number (or do whatever you need to do here, based on your object
        //        NSInteger tagIndex = [(UIButton *)sender tag];
        //
        //        // Pass the information to your destination view
        //        [vc setSelectedButton:tagIndex];
    }
}
@end

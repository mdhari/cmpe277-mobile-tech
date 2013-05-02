//
//  PolicyViewController.m
//  MyInsurance
//
//  Created by Michael Hari on 4/30/13.
//  Copyright (c) 2013 San Jose State University. All rights reserved.
//

#import "PolicyViewController.h"
#import "Policy.h"
#import "Vehicle.h"
#import "Driver.h"
#import "VehicleInfoViewController.h"
#import "DriverInfoViewController.h"

@interface PolicyViewController ()

@end

@implementation PolicyViewController

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
    
    self.policy = [[Policy alloc]init];
//    Vehicle *vehicle = [[Vehicle alloc] init];
//    vehicle.make=@"Ford";
//    vehicle.model=@"MustageGT";
//    vehicle.year=2011;
//    vehicle.vin=@"123551asdfasdf";
//    [self.policy.vehicles addObject:vehicle];
//    
//    Driver *driver = [[Driver alloc]init];
//    driver.fullName=@"Michael David Hari";
//    [self.policy.drivers addObject:driver];
    
    [self.policy getDataFromWebService];
    [self.tableView reloadData];
    

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

#pragma mark - Table view data source

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"Drivers";
    else
        return @"Vehicles";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    //return 0;
    switch(section){
        case 0:
            return [self.policy.drivers count];
            break;
        case 1:
            return [self.policy.vehicles count];
            break;
        default:
            return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"cellForRow");
    
    UITableViewCell *cell;
    //cell.textLabel.text=@"test";

    
    switch([indexPath section]){
        case 0:
            cell = [tableView dequeueReusableCellWithIdentifier:@"simpleCell" forIndexPath:indexPath];
            cell.textLabel.text=[self.policy.drivers[indexPath.row] fullName];
            
//            label = (UILabel *)[cell viewWithTag:2];
//            label.text=[self.policy.drivers[indexPath.row] licenseId];
//            
//            label = (UILabel *)[cell viewWithTag:3];
//            label.text=[self.policy.drivers[indexPath.row] address1];
//            
//            label = (UILabel *)[cell viewWithTag:4];
//            label.text=[self.policy.drivers[indexPath.row] address2];
//            
//            label = (UILabel *)[cell viewWithTag:5];
//            label.text=[self.policy.drivers[indexPath.row] city];
//            
//            label = (UILabel *)[cell viewWithTag:6];
//            label.text=[@([self.policy.drivers[indexPath.row] zipcode]) stringValue];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"simpleCell" forIndexPath:indexPath];
            cell.textLabel.text=[NSString stringWithFormat:@"%@ %@",[self.policy.vehicles[indexPath.row] make],[self.policy.vehicles[indexPath.row] model]];
            break;
    }
    
    return cell;
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

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"driverInfoSegue"]){
        DriverInfoViewController *driverInfoViewController = [segue destinationViewController];
        Driver *driver = sender;
        driverInfoViewController.licenseIDText=driver.licenseId;
        driverInfoViewController.fullNameText=driver.fullName;
        driverInfoViewController.addressText=driver.address1;
        driverInfoViewController.cityText=driver.city;
        driverInfoViewController.stateText=driver.state;
        driverInfoViewController.zipcodeText=[@(driver.zipcode) stringValue];
        driverInfoViewController.dobText=driver.dob;
    
        
    }
    
    
    
    if([segue.identifier isEqualToString:@"vehicleInfoSegue"]){
        VehicleInfoViewController *vehicleInfoViewController = [segue destinationViewController];
        Vehicle *vehicle = sender;
        vehicleInfoViewController.vinText=vehicle.vin;
        vehicleInfoViewController.makeText=vehicle.make;
        vehicleInfoViewController.modelText=vehicle.model;
        vehicleInfoViewController.yearText=[@(vehicle.year) stringValue];
        
        
    }
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if([indexPath section] == 0){
        [self performSegueWithIdentifier:@"driverInfoSegue" sender:self.policy.drivers[indexPath.row]];
    }
    else if([indexPath section] == 1){
        [self performSegueWithIdentifier:@"vehicleInfoSegue" sender:self.policy.vehicles[indexPath.row]];
    }
}



@end

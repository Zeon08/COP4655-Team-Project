//
//  TruckViewController.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "TruckViewController.h"
#import "Company.h"
#import "CompanyStore.h"
#import "CompanyViewController.h"
#import "Truck.h"
#import "NewTruckViewController.h"

@interface TruckViewController ()

@end

@implementation TruckViewController
@synthesize company;
@synthesize theContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewTruck:)];
        
        [[self navigationItem] setRightBarButtonItem:bbi];
    }
    return self;
}

-(void) setCompany:(Company *)c
{
    company = c;
    [[self navigationItem] setTitle:[company companyName]];
    
}

-(void)setTheContext:(NSManagedObjectContext *)ct
{
    theContext = ct;
}

-(IBAction)addNewTruck:(id)sender
{
    Truck *newTruck = [[CompanyStore defaultStore]createTruck];
    
    NewTruckViewController *newTruckViewController = [[NewTruckViewController alloc]init];
    
    [newTruckViewController setTruck:newTruck];
    
    [newTruckViewController setCompany:company];
   
    
    [newTruckViewController setDismissBlock:^{
        [[self tableView] reloadData];
        //[company addTrucksObject:newTruck];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newTruckViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];
  
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[company trucks]count];
    
    //return [[[TruckStore defaultStore]allTrucks]count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
   
    
//    Truck *t = [[[TruckStore defaultStore]allTrucks]objectAtIndex:[indexPath row]];
    
    Truck *tt = [[[company trucks]allObjects]objectAtIndex:[indexPath row]];
    
    cell.textLabel.text=[tt vin];
    
    return cell;
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


- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
       
    
    
}





#pragma mark - Table view data source





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



@end

//
//  CompanyViewController.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "CompanyViewController.h"
#import "Company.h"
#import "CompanyStore.h"
#import "NewCompanyViewController.h"
#import "TruckViewController.h"

@interface CompanyViewController ()

@end

@implementation CompanyViewController


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        UINavigationItem *n = [self navigationItem];
        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        UIImageView *img = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"rech.png"]];
        n.titleView = img;
        
        searchResults = [[NSMutableArray alloc] init];
        searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        
        
        searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
        
        searchDisplayController.delegate = (id)self;
        searchDisplayController.searchResultsDataSource = self;
        
        self.tableView.tableHeaderView = searchBar;
        
        [[self navigationItem] setRightBarButtonItem:bbi];
    }
    return self;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}



-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [searchResults removeAllObjects];
    
    Company *element;
    NSArray *companies = [[CompanyStore defaultStore]allCompanies];
    /* in this loop I search through every element (group) (see the code on top) in
     the "originalData" array, if the string match, the element will be added in a
     new array called newGroup. Then, if newGroup has 1 or more elements, it will be
     added in the "searchData" array. shortly, I recreated the structure of the
     original array "originalData". */
    
    for(element in companies) //take the n group (eg. group1, group2, group3)
        //in the original data
    {
        
        NSMutableArray *newGroup = [[NSMutableArray alloc] init];
        Company *element;
        
        if ([[element companyName] isEqualToString:searchString]) {
            [newGroup addObject:element]; }
        
        if ([newGroup count] > 0) {
            [searchResults addObject:newGroup];
        }
        
    }
    
    return YES;}

-(IBAction)addNewItem:(id)sender
{
    Company *newCompany = [[CompanyStore defaultStore]createCompany];
    
    
    
    NewCompanyViewController *newCompanyViewController = [[NewCompanyViewController alloc]init];
    
    [newCompanyViewController setCompany:newCompany];
    
    [newCompanyViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
    
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newCompanyViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    } else {
    return [[[CompanyStore defaultStore]allCompanies]count];
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    Company *c = [[[CompanyStore defaultStore]allCompanies]objectAtIndex:[indexPath row]];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
    cell.textLabel.text = [c companyName];
    }
    return cell;

}

- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TruckViewController *truckViewController = [[TruckViewController alloc]init];
    NSArray *companies = [[CompanyStore defaultStore]allCompanies];
    Company *selectedCompany = [companies objectAtIndex:[indexPath row]];
    
    NSManagedObjectContext *companyContext = [[CompanyStore defaultStore]theContext];
    
    
    [truckViewController setCompany:selectedCompany];
    [truckViewController setTheContext:companyContext];
    
    [[self navigationController]pushViewController:truckViewController animated:YES];
    
    
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

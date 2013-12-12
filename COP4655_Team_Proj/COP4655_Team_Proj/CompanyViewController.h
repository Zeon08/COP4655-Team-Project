//
//  CompanyViewController.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "NewCompanyViewController.h"
#import "TruckViewController.h"

@interface CompanyViewController : UITableViewController
<UISearchBarDelegate>
{
    UISearchBar *searchBar;
    UISearchDisplayController *searchDisplayController;
    NSMutableArray *searchResults;
    NSFetchedResultsController  *fetchedResultsController;
    NSManagedObjectContext      *managedObjectContext;
    
    NSArray *fetchedObjects;
    
}
@property (nonatomic, retain) UISearchBar *searchBar;
@property (nonatomic, retain) NSFetchedResultsController    *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext        *managedObjectContext;

-(IBAction)addNewItem:(id)sender;

@end

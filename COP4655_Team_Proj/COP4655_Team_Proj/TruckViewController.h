//
//  TruckViewController.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Company.h"
#import "CompanyStore.h"
#import "CompanyViewController.h"
#import "Truck.h"

@interface TruckViewController : UITableViewController
{
    UISearchBar *searchBar;
    NSManagedObjectContext *theContext;
}

@property (nonatomic, strong) Company *company;
@property (nonatomic, strong) NSManagedObjectContext *theContext;
-(IBAction)addNewTruck:(id)sender;
@end

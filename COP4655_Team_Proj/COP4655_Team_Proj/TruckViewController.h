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

@interface TruckViewController : UITableViewController
{
    UISearchBar *searchBar;
}

@property (nonatomic, strong) Company *company;

-(IBAction)addNewTruck:(id)sender;
@end

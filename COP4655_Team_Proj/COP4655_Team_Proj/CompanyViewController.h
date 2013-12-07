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

@interface CompanyViewController : UITableViewController
{
    UISearchBar *searchBar;
}

-(IBAction)addNewItem:(id)sender;

@end

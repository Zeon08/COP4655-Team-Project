//
//  WriteUpViewController.h
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/10/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Truck.h"
@interface WriteUpViewController : UITableViewController




@property (nonatomic, strong) NSManagedObjectContext *theContext;
@property (nonatomic, strong) Truck *truck;
-(IBAction)addNewItem:(id)sender;

@end





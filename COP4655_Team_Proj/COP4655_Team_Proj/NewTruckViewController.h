//
//  NewTruckViewController.h
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Truck;
@class Company;
@interface NewTruckViewController : UIViewController <UINavigationControllerDelegate>
@property (weak, nonatomic)IBOutlet UITextField * vinField;
@property (weak, nonatomic)IBOutlet UITextField * modelField;
@property (weak, nonatomic)IBOutlet UITextField * makeField;
@property (weak, nonatomic)IBOutlet UITextField * yearField;

@property (nonatomic, strong) Truck *truck;
@property (nonatomic, strong) Company *company;
@property (nonatomic, copy) void (^dismissBlock)(void);


@end

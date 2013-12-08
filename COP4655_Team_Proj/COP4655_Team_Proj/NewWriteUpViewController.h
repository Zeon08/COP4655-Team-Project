//
//  NewWriteUpViewController.h
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
//  Code added Michael Thomas 12/8/13
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "WriteUp.h"


@class WriteUp;

@interface NewWriteUpViewController : UIViewController <UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UITextField *complaintA;
@property (weak, nonatomic) IBOutlet UITextField *complaintB;
@property (weak, nonatomic) IBOutlet UITextField *complaintC;
@property (weak, nonatomic) IBOutlet UITextField *complaintD;
@property (weak, nonatomic) IBOutlet UIDatePicker *promiseDate;
@property (weak, nonatomic) IBOutlet UIImageView *imageField;

@property (weak, nonatomic) IBOutlet UITextField *estimateField;
@property (nonatomic, strong) WriteUp *writeup;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)takePhoto:(id)sender;


@end

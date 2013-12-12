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
#import <MobileCoreServices/UTCoreTypes.h>
#import "WriteUp.h"
#import "Company.h"
#import "Truck.h"

@class WriteUp;

@interface NewWriteUpViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIScrollViewAccessibilityDelegate,UIImagePickerControllerDelegate>
{
    UIImage *theImage;
    IBOutlet UIScrollView *scrollView;
}
@property (strong, nonatomic) IBOutlet UILabel *vinField;
@property (strong, nonatomic) IBOutlet UILabel *milesField;
@property (strong, nonatomic) IBOutlet UILabel *makeField;
@property (strong, nonatomic) IBOutlet UILabel *modelField;
@property (strong, nonatomic) IBOutlet UILabel *yearField;
@property (strong, nonatomic) IBOutlet UILabel *nameField;
@property (strong, nonatomic) IBOutlet UILabel *addressField;
@property (strong, nonatomic) IBOutlet UILabel *phoneField;
@property (strong, nonatomic) Truck *truck;
@property (strong, nonatomic) Company *company;

@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIDatePicker *picker;

@property (strong, nonatomic) IBOutlet UITextField *datePromised;
@property (weak, nonatomic) IBOutlet UITextField *complaintA;
@property (weak, nonatomic) IBOutlet UITextField *complaintB;
@property (weak, nonatomic) IBOutlet UITextField *complaintC;
@property (weak, nonatomic) IBOutlet UITextField *complaintD;
@property (weak, nonatomic) IBOutlet UIImageView *imageField;
@property (weak, nonatomic) IBOutlet UITextField *estimateField;
@property (nonatomic, strong) WriteUp *writeup;
@property (nonatomic, copy) void (^dismissBlock)(void);

- (IBAction)takePhoto:(id)sender;
- (IBAction)textFieldReturn:(id)sender;

@end

//
//  NewCompanyViewController.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Company;

@interface NewCompanyViewController : UIViewController <UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *companyNameField;
@property (weak, nonatomic) IBOutlet UITextField *contactField;
@property (weak, nonatomic) IBOutlet UITextField *addressField;
@property (weak, nonatomic) IBOutlet UITextField *phoneField;

@property (nonatomic, strong) Company *company;
@property (nonatomic, copy) void (^dismissBlock)(void);
- (IBAction)textFieldReturn:(id)sender;
@end

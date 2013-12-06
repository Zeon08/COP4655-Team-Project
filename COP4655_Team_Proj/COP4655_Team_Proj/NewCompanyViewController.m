//
//  NewCompanyViewController.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "NewCompanyViewController.h"
#import "Company.h"
#import "CompanyStore.h"

@interface NewCompanyViewController ()

@end

@implementation NewCompanyViewController
@synthesize company;
@synthesize dismissBlock;
@synthesize companyNameField, contactField, addressField, phoneField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *done = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(save:)];
        [[self navigationItem]setRightBarButtonItem:done];
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [[self navigationItem]setLeftBarButtonItem:cancel];
    }
    return self;
}

-(void) setCompany:(Company *)c
{
    company = c;
    
    [[self navigationItem] setTitle:[company companyName]];
}

- (IBAction)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (IBAction)cancel:(id)sender
{
    [[CompanyStore defaultStore]removeCompany:company];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [companyNameField setText:[company companyName]];
    [contactField setText:[company contactPerson]];
    [addressField setText:[company address]];
    [phoneField setText:[company phoneNumber]];
    
    
    [[self navigationItem] setTitle:[company companyName]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing:YES];
    
    [company setCompanyName:[companyNameField text]];
    [company setContactPerson:[contactField text]];
    [company setPhoneNumber:[phoneField text]];
    [company setAddress:[addressField text]];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

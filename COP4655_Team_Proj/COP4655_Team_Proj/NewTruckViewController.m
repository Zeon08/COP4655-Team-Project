//
//  NewTruckViewController.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "NewTruckViewController.h"
#import "Truck.h"
#import "Company.h"
#import "CompanyStore.h"

@interface NewTruckViewController ()

@end

@implementation NewTruckViewController
@synthesize truck,dismissBlock,vinField,makeField,modelField, yearField;
@synthesize company;

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


-(void) setTruck:(Truck *)t 
{
    truck = t;
    
    [[self navigationItem] setTitle:[truck vin]];
}

-(void) setCompany:(Company *)c
{
    company = c;
}
- (IBAction)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (IBAction)cancel:(id)sender
{
    [[CompanyStore defaultStore]removeTruck:truck];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [vinField setText:[truck vin]];
    [makeField setText:[truck make]];
    [modelField setText:[truck model]];
    [yearField setText:[truck year]];
    
    
    [[self navigationItem] setTitle:[truck vin]];
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
    
    [truck setVin:[vinField text]];
    [truck setModel:[modelField text]];
    [truck setMake:[makeField text]];
    [truck setYear:[yearField text]];
    NSSet *myTrucks = [[NSSet alloc]initWithObjects:truck, nil];
    
    [company addTrucks:myTrucks];
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

//
//  NewWriteUpViewController.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
// Code added Michael Thomas 12/8/2013
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "NewWriteUpViewController.h"
#import "WriteUp.h"
#import "CompanyStore.h"

@interface NewWriteUpViewController ()

@end

@implementation NewWriteUpViewController
@synthesize writeup;
@synthesize dismissBlock;
@synthesize complaintA, complaintB, complaintC, complaintD, promiseDate, estimateField, imageField;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        UIBarButtonItem *done = [[UIBarButtonItem alloc]
                initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self
                action:@selector(save:)];
        [[self navigationItem]setRightBarButtonItem:done];
        
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel:)];
        [[self navigationItem]setLeftBarButtonItem:cancel];
    }
    return self;
}

-(void) setWriteUp:(WriteUp *)w
{
    writeup = w;
    
    //[[self navigationItem] setTitle:[writeup datePromised]];
}

- (IBAction)save:(id)sender
{
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:dismissBlock];
}

- (IBAction)cancel:(id)sender
{
    [[CompanyStore defaultStore]removeWriteUp:writeup];
    
    [[self presentingViewController] dismissViewControllerAnimated:YES completion:
     dismissBlock];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [complaintA setText:[writeup complaintA]];
    [complaintB setText:[writeup complaintB]];
    [complaintC setText:[writeup complaintC]];
    [complaintD setText:[writeup complaintD]];
    [estimateField setText:[writeup estimate]];
//    [promiseDate setCalendar:[writeup datePromised]];
    //[imageField setImage:[writeup image]];
    
    //[[self navigationItem] setTitle:[writeup promiseDate]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[self view] endEditing: YES];
    
    [writeup setComplaintA:[complaintA text]];
    [writeup setComplaintB:[complaintB text]];
    [writeup setComplaintC:[complaintC text]];
    [writeup setComplaintD:[complaintD text]];
    [writeup setEstimate:[estimateField text]];
    //[writeup setDatePromised:[promiseDate]];
    //[writeup setImage:[imageField]];
    
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

- (IBAction)takePhoto:(id)sender {
}
@end

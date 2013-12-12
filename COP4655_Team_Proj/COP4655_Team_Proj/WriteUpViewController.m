//
//  WriteUpViewController.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/10/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//



#import "WriteUpViewController.h"
#import "WriteUp.h"
#import "Company.h"
#import "CompanyStore.h"
#import "NewWriteUpViewController.h"
#import "CompanyViewController.h"
#import "WriteUpDetailViewController.h"

@interface WriteUpViewController ()

@end

@implementation WriteUpViewController

@synthesize truck, company;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        

        UIBarButtonItem *bbi = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                target:self
                                action:@selector(addNewItem:)];
        
        
        [[self navigationItem] setRightBarButtonItem:bbi];
    }
    return self;
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[self tableView] reloadData];
}

-(void)setTruck:(Truck *)t
{
    truck=t;
    [[self navigationItem] setTitle:[truck vin]];
}
-(void)setCompany:(Company *)c
{
    company = c;
}

-(IBAction)addNewItem:(id)sender
{
    WriteUp *newWriteUp = [[CompanyStore defaultStore]createWriteUp];
    
    NewWriteUpViewController *newWriteUpViewController = [[NewWriteUpViewController alloc]init];
    
    [newWriteUpViewController setWriteup:newWriteUp];
    
    // Edited by Javier Casaudoumecq ------------------------------
    [newWriteUpViewController setTruck:truck];
    [newWriteUpViewController setCompany:company];
    //-------------------------------------------------------------
    
    [newWriteUpViewController setDismissBlock:^{
        [[self tableView] reloadData];
    }];
        UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:newWriteUpViewController];
    
    [navController setModalPresentationStyle:UIModalPresentationFormSheet];
    [navController setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
    
    [self presentViewController:navController animated:YES completion:nil];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [[truck writeUps]count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
//Luisa's code
    //WriteUp *w = [[[truck writeUps]allObjects]objectAtIndex:[indexPath row]];
    //NSString* myNewString = [NSString stringWithFormat:@"%f", [w datePromised]];
    //cell.textLabel.text=myNewString;

    
    
    WriteUp *w = [[[truck writeUps]allObjects]objectAtIndex:[indexPath row]];
    //NSData *theDate = [NSDate dateWithTimeIntervalSince1970:[w datePromised]];
    
    //NSString* myNewString = [NSString stringWithFormat:@"%@", theDate];
    NSString* myNewString = [w datePromised];
    cell.textLabel.text= myNewString;
    

    return cell;
    
    
}

- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WriteUpDetailViewController *writeupdetailviewcontroller = [[WriteUpDetailViewController alloc]init];
//Luisa's code
   // NSArray *writeups = [[CompanyStore defaultStore]allWriteUps];
    //WriteUp *selectedWriteUp = [writeups objectAtIndex:[indexPath row]];
    //[writeupdetailviewcontroller setWriteUp:selectedWriteUp];
        

    
    // Edited by Javier Casaudoumecq ---------------------------------
    NSArray *writeUps = [[truck writeUps]allObjects ];
    WriteUp *selectedWriteUp = [writeUps objectAtIndex:[indexPath row]];
    
    [writeupdetailviewcontroller setWriteUp:selectedWriteUp];
    //----------------------------------------------------------------
    
    

    [[self navigationController]pushViewController:writeupdetailviewcontroller animated:YES];
    
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





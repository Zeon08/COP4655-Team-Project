//
//  WriteUpViewController.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/10/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//



#import "WriteUpViewController.h"
#import "WriteUp.h"
#import "CompanyStore.h"
#import "NewWriteUpViewController.h"
#import "CompanyViewController.h"
#import "WriteUpDetailViewController.h"

@interface WriteUpViewController ()

@end

@implementation WriteUpViewController

@synthesize truck;



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
   [ [self navigationItem]setTitle:[truck vin]];

    truck =t;

}

-(IBAction)addNewItem:(id)sender
{
    WriteUp *newWriteUp = [[CompanyStore defaultStore]createWriteUp];
    
    NewWriteUpViewController *newWriteUpViewController = [[NewWriteUpViewController alloc]init];
    
    [newWriteUpViewController setWriteup:newWriteUp];
    
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
    //return [[[CompanyStore defaultStore]allCompanies]count];
    return [[truck writeUps]count];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *MyIdentifier = @"MyIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
    
    WriteUp *w = [[[truck writeUps]allObjects]objectAtIndex:[indexPath row]];
    NSString* myNewString = [NSString stringWithFormat:@"%f", [w datePromised]];
    cell.textLabel.text=myNewString;
    return cell;
    
    
}

- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WriteUpDetailViewController *writeupdetailviewcontroller = [[WriteUpDetailViewController alloc]init];
    NSArray *writeups = [[CompanyStore defaultStore]allWriteUps];
    WriteUp *selectedWriteUp = [writeups objectAtIndex:[indexPath row]];
    [writeupdetailviewcontroller setWriteUp:selectedWriteUp];
        
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





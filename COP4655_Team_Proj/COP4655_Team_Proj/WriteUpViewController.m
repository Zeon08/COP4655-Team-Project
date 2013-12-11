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

@interface WriteUpViewController ()

@end

@implementation WriteUpViewController

@synthesize truck;
@synthesize theContext;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        //UINavigationItem *n = [self navigationItem];
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
    
    
    
    //    Truck *t = [[[TruckStore defaultStore]allTrucks]objectAtIndex:[indexPath row]];
    
    WriteUp *w = [[[truck writeUps]allObjects]objectAtIndex:[indexPath row]];
    NSString* myNewString = [NSString stringWithFormat:@"%f", [w datePromised]];
    cell.textLabel.text=myNewString;
    //NSString stringWithFormat:@"%d", myInt]
    return cell;
    
    
}

- (void)tableView:(UITableView *)aTableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //TruckViewController *truckViewController = [[TruckViewController alloc]init];
    //NSArray *companies = [[CompanyStore defaultStore]allCompanies];
    //Company *selectedCompany = [companies objectAtIndex:[indexPath row]];
    
    //NSManagedObjectContext *companyContext = [[CompanyStore defaultStore]theContext];
    
    
    //[truckViewController setCompany:selectedCompany];
    //[truckViewController setTheContext:companyContext];
    
    //[[self navigationController]pushViewController:truckViewController animated:YES];
    
    
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





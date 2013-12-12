//
//  WriteUpDetailViewController.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/10/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "WriteUpDetailViewController.h"
#import "WriteUp.h"

@interface WriteUpDetailViewController ()

@end

@implementation WriteUpDetailViewController

@synthesize writeup, complaintAField, complaintBField, complaintCField, complaintDField,estimateField,imageField,datePromisedField;

//@synthesize writeUp;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//Javier
//-(void)setWriteUp:(WriteUp *)w
//{
  //  writeUp =w;
    //NSString *date = [NSString stringWithFormat:@"%f",[w datePromised]];
    
    //[[self navigationItem]setTitle:date];
    
//}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    complaintAField.text=[writeup complaintA];
    complaintBField.text=[writeup complaintB];
    complaintCField.text=[writeup complaintC];
    complaintDField.text=[writeup complaintD];
    estimateField.text=[writeup estimate];
    datePromisedField.text=[writeup datePromised];
    NSData *data = [writeup image];
    
    UIImage *image = [[UIImage alloc] initWithData:data];
    
    imageField.image=image;
    
    
    
}

//Luisa
-(void) setWriteUp:(WriteUp *)w
{
    writeup = w;
    [[self navigationItem] setTitle:[writeup estimate]];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

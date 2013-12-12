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
#import "Company.h"
#import "Truck.h"

@interface NewWriteUpViewController ()

@end

@implementation NewWriteUpViewController
@synthesize writeup,company,truck;
@synthesize dismissBlock, picker;
@synthesize complaintA, complaintB, complaintC, complaintD, estimateField, imageField;
@synthesize vinField,milesField,makeField,modelField,yearField,nameField,addressField,phoneField;
@synthesize scrollView;

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
    
}
-(void)setCompany:(Company *)c
{
    company =c;

}
-(void)setTruck:(Truck *)t
{
    truck = t;
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
    
    [[self vinField]setText:[truck vin]];
    [[self makeField]setText:[truck make]];
    [[self modelField]setText:[truck model]];
    [[self yearField]setText:[truck model]];
    [[self nameField]setText:[company companyName]];
    [[self addressField]setText:[company address]];
    [[self phoneField]setText:[company phoneNumber]];
    
    
    [complaintA setText:[writeup complaintA]];
    [complaintB setText:[writeup complaintB]];
    [complaintC setText:[writeup complaintC]];
    [complaintD setText:[writeup complaintD]];
    [estimateField setText:[writeup estimate]];
    
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
    NSData *imageData = [[NSData alloc]initWithData:UIImagePNGRepresentation(theImage)];
    [writeup setImage:imageData];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    // this is imporant - we set our input date format to match our string in the field
    // if format doesn't match you'll get nil from your string, so be careful
    [dateFormatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSDate *date = [[NSDate alloc] init];
    
    date = [dateFormatter dateFromString:self.datePromised.text];
    
    NSTimeInterval timeInterval = [date timeIntervalSinceReferenceDate];
    [writeup setDatePromised:timeInterval];
    
    
    NSSet *myWriteUps = [[NSSet alloc]initWithObjects:writeup, nil];
    [truck addWriteUps:myWriteUps];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [scrollView setScrollEnabled:YES];
    
    [scrollView setContentSize:CGSizeMake(320, 1000)];
    
    picker = [[UIDatePicker alloc]init];
    
    
    picker.datePickerMode = UIDatePickerModeDate;
    
    [picker addTarget:self action:@selector(changeDateInLabel:) forControlEvents:UIControlEventValueChanged];
    
    
    self.complaintA.delegate =(id)self;
    self.complaintB.delegate =(id)self;
    self.complaintC.delegate = (id)self;
    self.complaintD.delegate = (id)self;
    self.estimateField.delegate = (id)self;
    self.datePromised.delegate = (id)self;
    self.datePromised.inputView = picker;
    
    [self.complaintA setReturnKeyType:UIReturnKeyDone];
    [self.complaintB setReturnKeyType:UIReturnKeyDone];
    [self.complaintC setReturnKeyType:UIReturnKeyDone];
    [self.complaintD setReturnKeyType:UIReturnKeyDone];
    [self.estimateField setReturnKeyType:UIReturnKeyDone];
}
- (void)changeDateInLabel:(id)sender{
    NSDate * time = picker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    
    NSString *date = [formatter stringFromDate:time];
    
    self.datePromised.text = date;
   
}

-(void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"picker view selected");
    NSDate * time = picker.date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    
    NSString *date = [formatter stringFromDate:time];
    
    self.datePromised.text = date;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [self.complaintA resignFirstResponder];
    [self.complaintB resignFirstResponder];
    [self.complaintC resignFirstResponder];
    [self.complaintD resignFirstResponder];
    [self.estimateField resignFirstResponder];
    
    return YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)takePhoto:(id)sender {
    [self startCameraControllerFromViewController: self
                                    usingDelegate: (id)self];
}

- (BOOL) startCameraControllerFromViewController: (UIViewController*) controller usingDelegate: (id <UIImagePickerControllerDelegate,UINavigationControllerDelegate>) delegate {
    
    
    if (([UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera] == NO)
        || (delegate == nil)
        || (controller == nil))
        return NO;
    
    // Create the picker object
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    // Specify the types of camera features available
    cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    
    // Displays a control that allows the user to take pictures only.
    cameraUI.mediaTypes = [[NSArray alloc] initWithObjects: (NSString *) kUTTypeImage, nil];
    
    
    // Hides the controls for moving & scaling pictures, or for
    // trimming movies. To instead show the controls, use YES.
    cameraUI.allowsEditing = NO;
    
    // Specify which object contains the picker's methods
    cameraUI.delegate = delegate;
    
    // Picker object view is attached to view hierarchy and displayed.
    [controller presentViewController: cameraUI animated: YES completion: nil ];
    return YES;
    
}
- (void) imagePickerController: (UIImagePickerController *) picker
 didFinishPickingMediaWithInfo: (NSDictionary *) info {
    
    // Create an image and store the acquired picture
    UIImage  *imageToSave;
    imageToSave = (UIImage *) [info objectForKey:
                               UIImagePickerControllerOriginalImage];
    
    theImage = imageToSave;
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    NSLog(@"you took a picture");
    // View the image on screen
    [self.imageField setImage:theImage];
   
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion: ^{[self doSomethingElse];} ];
    
}

- (IBAction)textFieldReturn:(id)sender {
    
    [sender resignFirstResponder];
}

- (void) doSomethingElse {
    NSLog(@"Camera Dismissed");
    
}

@end

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
    //Convert the NSTimeInterval stored in core data into a date format for the date time picker
    NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:[writeup datePromised]];
    [promiseDate setDate:date];
    //Convert the data from core data into an image to load.
    UIImage *image = [UIImage imageWithData:[writeup image]];
    [imageField setImage:image];
    
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
    [writeup setDatePromised:promiseDate.countDownDuration];
    NSData *imageData = UIImagePNGRepresentation(imageField);
    [writeup setImage:imageData];
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
    
    //theImage = imageToSave;
    
    // Save the new image to the Camera Roll
    UIImageWriteToSavedPhotosAlbum (imageToSave, nil, nil , nil);
    
    NSLog(@"you took a picture");
    // View the image on screen
    [self.imageField setImage:imageToSave];
   
    
    // Tell controller to remove the picker from the view hierarchy and release object.
    [self dismissViewControllerAnimated: YES completion: ^{[self doSomethingElse];} ];
    
}

- (void) doSomethingElse {
    NSLog(@"Camera Dismissed");
    
}

@end

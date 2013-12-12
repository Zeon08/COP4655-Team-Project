//
//  WriteUpDetailViewController.h
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/10/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WriteUp.h"

@interface WriteUpDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *complaintAField;
@property (weak, nonatomic) IBOutlet UILabel *complaintBField;
@property (weak, nonatomic) IBOutlet UILabel *complaintCField;
@property (weak, nonatomic) IBOutlet UILabel *complaintDField;

@property (nonatomic, strong) WriteUp *writeup;

-(void) setWriteUp:(WriteUp *)w;

@end

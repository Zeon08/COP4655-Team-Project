//
//  WriteUp.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//
// Changes made by Michael Thomas 12/8/2013:
// Removed DTU, State, and License and Unit number not needed for writeup.

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Truck;

@interface WriteUp : NSManagedObject


@property (nonatomic, retain) NSString * complaintA;
@property (nonatomic, retain) NSString * complaintB;
@property (nonatomic, retain) NSString * complaintC;
@property (nonatomic, retain) NSString * complaintD;
@property (nonatomic, retain) NSData * image;
//@property (nonatomic) NSTimeInterval datePromised;
@property (nonatomic, retain) NSString * datePromised;
@property (nonatomic, retain) NSString * estimate;
@property (nonatomic, retain) Truck *truck;

@end

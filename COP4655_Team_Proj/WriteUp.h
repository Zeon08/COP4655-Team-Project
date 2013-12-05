//
//  WriteUp.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Truck;

@interface WriteUp : NSManagedObject

@property (nonatomic, retain) NSString * dtu;
@property (nonatomic, retain) NSString * licenseNumber;
@property (nonatomic, retain) NSString * complaintB;
@property (nonatomic, retain) NSString * complaintA;
@property (nonatomic, retain) NSString * state;
@property (nonatomic, retain) NSString * unitNumber;
@property (nonatomic, retain) NSString * complaintC;
@property (nonatomic, retain) NSData * image;
@property (nonatomic, retain) NSString * complaintD;
@property (nonatomic) NSTimeInterval datePromised;
@property (nonatomic, retain) NSString * estimate;
@property (nonatomic, retain) Truck *truck;

@end

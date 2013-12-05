//
//  Company.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

//comment

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Truck;

@interface Company : NSManagedObject

@property (nonatomic, retain) NSString * companyName;
@property (nonatomic, retain) NSString * phoneNumber;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * contactPerson;
@property (nonatomic, retain) NSSet *trucks;
@end

@interface Company (CoreDataGeneratedAccessors)

- (void)addTrucksObject:(Truck *)value;
- (void)removeTrucksObject:(Truck *)value;
- (void)addTrucks:(NSSet *)values;
- (void)removeTrucks:(NSSet *)values;

@end

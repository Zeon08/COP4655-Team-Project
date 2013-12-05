//
//  Truck.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Truck : NSManagedObject

@property (nonatomic, retain) NSString * vin;
@property (nonatomic, retain) NSString * model;
@property (nonatomic, retain) NSString * make;
@property (nonatomic, retain) NSString * year;
@property (nonatomic, retain) NSManagedObject *company;
@property (nonatomic, retain) NSSet *writeUps;
@end

@interface Truck (CoreDataGeneratedAccessors)

- (void)addWriteUpsObject:(NSManagedObject *)value;
- (void)removeWriteUpsObject:(NSManagedObject *)value;
- (void)addWriteUps:(NSSet *)values;
- (void)removeWriteUps:(NSSet *)values;

@end

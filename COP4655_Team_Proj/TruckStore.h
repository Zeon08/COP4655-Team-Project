//
//  TruckStore.h
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>




@class Truck;

@interface TruckStore : NSObject
{
    NSMutableArray *allTrucks;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+(TruckStore *)defaultStore;

-(void)removeTruck: (Truck *)t;

-(NSArray *)allTrucks;

-(NSString *)TruckArchivePath;

-(Truck *)createTruck;

- (BOOL)saveChanges;

- (void)loadAllTrucks;



@end

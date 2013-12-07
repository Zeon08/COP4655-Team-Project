//
//  TruckStore.m
//  COP4655_Team_Proj
//
//  Created by Luisa Daniela Barros on 12/7/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "TruckStore.h"
#import "Truck.h"

@implementation TruckStore

+(TruckStore *)defaultStore
{
    static TruckStore *defaultStore = nil;
    if(!defaultStore)
        defaultStore = [[super allocWithZone:nil]init];
    
    return defaultStore;
}

+(id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
    
}

-(id)init
{
    self = [super init];
    
    
    if(self)
    {
        
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        
        NSPersistentStoreCoordinator *psc =
        [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
        
        
        NSString *path = [self TruckArchivePath];
        NSURL *storeURL = [NSURL fileURLWithPath:path];
        
        NSError *error = nil;
        
        if (![psc addPersistentStoreWithType:NSSQLiteStoreType
                               configuration:nil
                                         URL:storeURL
                                     options:nil
                                       error:&error]) {
            [NSException raise:@"Open failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        // Create the managed object context
        context = [[NSManagedObjectContext alloc] init];
        [context setPersistentStoreCoordinator:psc];
        
        // The managed object context can manage undo, but we don't need it
        [context setUndoManager:nil];
        
        [self loadAllTrucks];
        
    }
    return self;
}

-(void)loadAllTrucks
{
    if (!allTrucks) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Truck"];
        [request setEntity:e];
                
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if(!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allTrucks = [[NSMutableArray alloc]initWithArray:result];
        
        
    }
}

-(NSString *) TruckArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:@"store.data"];
}

- (BOOL)saveChanges
{
    NSError *err = nil;
    BOOL successful = [context save:&err];
    if (!successful) {
        NSLog(@"Error saving: %@", [err localizedDescription]);
    }
    return successful;
}

-(void)removeTruck:(Truck *)t
{
    [context deleteObject:t];
    [allTrucks removeObjectIdenticalTo:t];
}

-(NSArray *) allTrucks
{
    return allTrucks;
}

-(Truck *)createTruck
{
    Truck *t = [NSEntityDescription insertNewObjectForEntityForName:@"Truck" inManagedObjectContext:context];
    
    [allTrucks addObject:t];
    
    return t;
}



@end

//
//  WriteUpStore.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "WriteUpStore.h"

@implementation WriteUpStore

+(WriteUpStore *)defaultStore
{
    static WriteUpStore *defaultStore = nil;
    if(!defaultStore)
        defaultStore = [[super allocWithZone:nil]init];
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

-(id) init
{
    self = [super init];
    if(self) {
        model = [NSManagedObjectModel mergedModelFromBundles:nil];
        
        NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:model];
        
        NSString *path = [self itemArchivePath];
        
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
        
        [self loadAllItems];
    }
    return self;    
}

- (void)loadAllItems
{
    if (!allWriteUps) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"WriteUp"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor
                                sortDescriptorWithKey:@"orderingValue"
                                ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed"
                        format:@"Reason: %@", [error localizedDescription]];
        }
        
        allWriteUps = [[NSMutableArray alloc] initWithArray:result];
    }
}

@end

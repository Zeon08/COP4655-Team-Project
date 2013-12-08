//
//  WriteUpStore.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
// Code Added by Michael Thomas on 12/8/2013
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "WriteUpStore.h"
#import "WriteUp.h"

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
        
        NSString *path = [self writeUpArchivePath];
        
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
        
        [self loadAllWriteUps];
    }
    return self;    
}

- (void)loadAllWriteUps
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

-(NSString *) writeUpArchivePath
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

-(void)removedWriteUp:(WriteUp *)w
{
    [context deleteObject:w];
    [allWriteUps removeObjectIdenticalTo:w];
}

-(NSArray *) allWriteUps
{
    return allWriteUps;
}

-(WriteUp *)createWriteUp
{
    WriteUp *w = [NSEntityDescription insertNewObjectForEntityForName:@"Writeup" inManagedObjectContext:context];
    
    [allWriteUps addObject:w];
    
    return w;
}







@end

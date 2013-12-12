//
//  CompanyStore.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "CompanyStore.h"
#import "Company.h"
#import "Truck.h"
#import "WriteUp.h"
#import "CompanyViewController.h"

@implementation CompanyStore

+(CompanyStore *)defaultStore
{
    static CompanyStore *defaultStore = nil;
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
        
       
        NSString *path = [self companyArchivePath];
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
        
        [self loadAllCompanies];
        [self loadallTrucks];
        [self loadallWriteUps];
        
        

    }
    return self;
}

-(NSManagedObjectContext *) theContext
{
    return context;
}
-(void)loadAllCompanies
{
    if (!allCompanies) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Company"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"companyName" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if(!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allCompanies = [[NSMutableArray alloc]initWithArray:result];
        
         
    }
}
-(void)loadallTrucks
{
    if (!allTrucks) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [[model entitiesByName]objectForKey:@"Truck"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"vin" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if(!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allTrucks = [[NSMutableArray alloc]initWithArray:result];
        
        
    }
}

-(void)loadallWriteUps
{
    if(!allWriteUps) {
        NSFetchRequest *request = [[NSFetchRequest alloc]init];
        
        NSEntityDescription *e = [[model entitiesByName]objectForKey:@"WriteUp"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"datePromised" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if(!result) {
            [NSException raise:@"Fetch failed" format:@"Reason: %@", [error localizedDescription]];
        }
        allWriteUps = [[NSMutableArray alloc]initWithArray:result];
    }
}

-(NSString *) companyArchivePath
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

-(void)removeCompany:(Company *)c
{
    [context deleteObject:c];
    [allCompanies removeObjectIdenticalTo:c];
}
-(void)removeTruck:(Truck *)t
{
     NSLog(@"Going to delete");
    NSLog(@"%@",allTrucks);
    [context deleteObject:t];
    [allTrucks removeObjectIdenticalTo:t];
}
-(void) removeWriteUp:(WriteUp *)w
{
    NSLog(@"Going to delete");
    [context deleteObject:w];
    [allWriteUps removeObjectIdenticalTo:w];

}

-(NSArray *) allCompanies
{
    return allCompanies;
}

-(NSArray *) allTrucks
{
    return allTrucks;
}
-(NSArray *) allWriteUps
{
    return allWriteUps;
}



-(Company *)createCompany
{
    Company *c = [NSEntityDescription insertNewObjectForEntityForName:@"Company" inManagedObjectContext:context];
    
    [allCompanies addObject:c];
    
    return c;
}
-(Truck *)createTruck
{
    Truck *t = [NSEntityDescription insertNewObjectForEntityForName:@"Truck" inManagedObjectContext:context];
    
    [allTrucks addObject:t];
    NSLog(@"Added truck");
    NSLog(@"%@",allTrucks);
    
    return t;
}
-(WriteUp *)createWriteUp
{
    WriteUp *w = [NSEntityDescription insertNewObjectForEntityForName:@"WriteUp" inManagedObjectContext:context];
    
    [allWriteUps addObject:w];
    NSLog(@"Added WriteUp");
    NSLog(@"%@",allWriteUps);
    return w;
}
@end

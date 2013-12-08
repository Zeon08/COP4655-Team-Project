//
//  CompanyStore.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Company, Truck, WriteUp;

@interface CompanyStore : NSObject
{
    NSMutableArray *allCompanies;
    NSMutableArray *allTrucks;
    NSMutableArray *allWriteUps;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+(CompanyStore *)defaultStore;

-(void)removeCompany:(Company *)c;
-(void)removeTruck:(Truck *)t;
-(void)removeWriteUp:(WriteUp *)w;

-(NSArray *)allCompanies;
-(NSArray *)allTrucks;
-(NSArray *)allWriteUps;

-(NSString *) companyArchivePath;



-(NSManagedObjectContext *) theContext;


-(Company *)createCompany;
-(Truck *)createTruck;
-(WriteUp *)createWriteUp;

-(BOOL)saveChanges;

-(void)loadAllCompanies;
-(void)loadallTrucks;
-(void)loadallWriteUps;
@end

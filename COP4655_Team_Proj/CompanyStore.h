//
//  CompanyStore.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@class Company;

@interface CompanyStore : NSObject
{
    NSMutableArray *allCompanies;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+(CompanyStore *)defaultStore;

-(void)removeCompany:(Company *)c;

-(NSArray *)allCompanies;

-(NSString *) companyArchivePath;

-(NSArray *)allTrucks;

//-(void)moveCompanyAtIndex:(int)from toIndex:(int)to;

-(Company *)createCompany;

-(BOOL)saveChanges;

-(void)loadAllCompanies;
@end

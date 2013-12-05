//
//  Company.m
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import "Company.h"

@implementation Company
@synthesize myCompanies;

-(id)init
{
    self = [super init];
    if (self)
    {
        
    }
    
    return self;
}

-(NSMutableArray *) myCompanies
{
    if (!myCompanies)
    {
        myCompanies = [[NSMutableArray alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"Data" ofType:@"plist"]];
    }
    return myCompanies;
}

// Creates a new company and adds it to the array of companies.
-(void)newCompany:(NSDictionary *) newCompany
{
    
}

// Deletes a company
-(void)deleteCompany:(NSDictionary *) theCompany
{
    
}

// Updates the comapny
-(void)updateCompany:(NSDictionary *) theUpdate
{
    
}
@end

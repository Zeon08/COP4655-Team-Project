//
//  Company.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/4/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Company : NSObject
{
    NSMutableArray *myCompanies;
    
}

@property (nonatomic, retain) NSMutableArray *myCompanies;

-(void)newCompany:(NSDictionary *) newCompany;

-(void)deleteCompany:(NSDictionary *) theCompany;

-(void)updateCompany:(NSDictionary *) theUpdate;

@end

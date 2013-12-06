//
//  WriteUpStore.h
//  COP4655_Team_Proj
//
//  Created by Javier Casaudoumecq on 12/5/13.
//  Copyright (c) 2013 Javier Casaudoumecq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class WriteUp;

@interface WriteUpStore : NSObject
{
    NSMutableArray *allWriteUps;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+(WriteUpStore *)defaultStore;

-(void)removeItem: (WriteUp *)w;

-(NSArray *)allWriteUps;

-(NSString *)writeUpArchivePath;

-(void)moveWriteUpAtIndex:(int)from
                toIndex:(int)to;

-(WriteUp *)createWriteUp;


- (BOOL)saveChanges;

- (void)loadAllWriteUps;



@end

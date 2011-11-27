//
//  VKWineStore.h
//  Viinikoodi
//
//  Created by Teemu Harju on 15.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

@class Wine;

@interface VKWineStore : NSObject
{
    NSMutableArray *allWines;
    NSMutableArray *allNotes;
    NSManagedObjectContext *context;
    NSManagedObjectModel *model;
}

+ (VKWineStore *)defaultStore;
- (BOOL)saveChanges;

#pragma mark Wines
- (NSArray *)allWines;
- (Wine *)createWineFromDict:(NSDictionary *)dict;
- (void)removeWine:(Wine *)wine;
- (void)moveWineAtIndex:(int)from toIndex:(int)to;
- (Wine *)fetchWineWithAlkoID:(int)alkoID;

@end

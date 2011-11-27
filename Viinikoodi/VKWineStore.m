//
//  VKWineStore.m
//  Viinikoodi
//
//  Created by Teemu Harju on 15.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VKWineStore.h"
#import "Wine.h"
#import "FileHelpers.h"

static VKWineStore *defaultStore = nil;

@implementation VKWineStore

+ (VKWineStore *)defaultStore
{
    if (!defaultStore) {
        defaultStore = [[super allocWithZone:NULL] init];
    }
    return defaultStore;
}

+ (id)allocWithZone:(NSZone *)zone
{
    return [self defaultStore];
}

- (id)init
{
    if (defaultStore) {
        return defaultStore;
    }
    
    self = [super init];
    
    model = [[NSManagedObjectModel mergedModelFromBundles:nil] retain];
    
    NSPersistentStoreCoordinator *psc = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:model];
  
    NSString *path = pathInDocumentDirectory(@"store.data");
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
    
    context = [[NSManagedObjectContext alloc] init];
    [context setPersistentStoreCoordinator:psc];
    [psc release];
    
    [context setUndoManager:nil];
    
    return self;
}

- (id)retain
{
    return self;
}

- (oneway void)release
{
    // Do nothing
}

- (NSUInteger)retainCount
{
    return NSUIntegerMax;
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

- (void)fetchWinesIfNecessary
{
    if (!allWines) {
        NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
        
        NSEntityDescription *e = [[model entitiesByName] objectForKey:@"Wine"];
        [request setEntity:e];
        
        NSSortDescriptor *sd = [NSSortDescriptor sortDescriptorWithKey:@"scanned" ascending:YES];
        [request setSortDescriptors:[NSArray arrayWithObject:sd]];
        
        NSError *error;
        NSArray *result = [context executeFetchRequest:request error:&error];
        if (!result) {
            [NSException raise:@"Fetch failed" format:@"Reason %@", [error localizedDescription]];
        }
        
        allWines = [[NSMutableArray alloc] initWithArray:result];
    }
}

- (NSArray *)allWines
{
    [self fetchWinesIfNecessary];
    
    return allWines;
}

- (Wine *)createWineFromDict:(NSDictionary *)dict
{
    [self fetchWinesIfNecessary];
    
    [dict retain];
    
    Wine *wine = [NSEntityDescription insertNewObjectForEntityForName:@"Wine" inManagedObjectContext:context];
    wine.alkoID = [NSNumber numberWithInt:[[dict valueForKey:@"alko_id"] intValue]];
    wine.ean = [NSNumber numberWithInt:[[dict valueForKey:@"ean"] intValue]];
    wine.name = [dict valueForKey:@"name"];
    wine.country = [dict valueForKey:@"country"];
    wine.region = [dict valueForKey:@"region"];
    wine.type = [dict valueForKey:@"type"];
    wine.grapes = [dict valueForKey:@"grapes"];
    wine.price = [NSNumber numberWithFloat:[[dict valueForKey:@"price"] floatValue]];
    wine.desc = [dict valueForKey:@"description"];
    wine.alkoURL = [dict valueForKey:@"url"];
    wine.alkoImageURL = [dict valueForKey:@"image_url"];
    wine.isFavourite = NO;
    wine.scanned = [[NSDate alloc] init];
    wine.bottleImageData = [dict valueForKey:@"image_data"];
    
    [allWines addObject:wine];
    
    [self saveChanges];
    
    [dict release];
    
    return wine;
}

- (void)removeWine:(Wine *)wine
{
    [context deleteObject:(NSManagedObject *)wine];
    [allWines removeObjectIdenticalTo:wine];
}

- (void)moveWineAtIndex:(int)from toIndex:(int)to
{
    if (from == to) {
        return;
    }
    
    Wine *wine = [allWines objectAtIndex:from];
    [wine retain];
    
    [allWines removeObjectAtIndex:from];
    
    [allWines insertObject:wine atIndex:to];
    
    [wine release];
}

- (Wine *)fetchWineWithAlkoID:(int)alkoID
{
    NSEntityDescription *ed = [NSEntityDescription entityForName:@"Wine" inManagedObjectContext:context];
    NSFetchRequest *r = [[[NSFetchRequest alloc] init] autorelease];
    [r setEntity:ed];
    
    NSPredicate *p = [NSPredicate predicateWithFormat:@"alkoID == %d", alkoID];
    
    [r setPredicate: p];
    NSError *error = nil;
    NSArray *objects = [context executeFetchRequest:r error:&error];
    if (objects == nil) {
        return nil;
    } else {
        if ([objects count] > 0) {
            return [objects objectAtIndex:0];
        } else {
            return nil;
        }
    }
}

@end

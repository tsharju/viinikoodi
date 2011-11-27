//
//  Wine.h
//  Viinikoodi
//
//  Created by Teemu Harju on 18.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Wine : NSManagedObject

@property (nonatomic, retain) NSNumber * alkoID;
@property (nonatomic, retain) NSNumber * ean;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * region;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * grapes;
@property (nonatomic, retain) NSNumber * price;
@property (nonatomic, retain) NSString * desc;
@property (nonatomic, retain) NSString * alkoURL;
@property (nonatomic, retain) NSString * alkoImageURL;
@property (nonatomic, retain) NSNumber * isFavourite;
@property (nonatomic, retain) NSDate * scanned;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) UIImage *bottleImage;
@property (nonatomic, retain) NSData *bottleImageData;

@end

@interface Wine (CoreDataGeneratedAccessors)

- (void)addNotesObject:(NSManagedObject *)value;
- (void)removeNotesObject:(NSManagedObject *)value;
- (void)addNotes:(NSSet *)values;
- (void)removeNotes:(NSSet *)values;

@end

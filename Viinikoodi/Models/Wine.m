//
//  Wine.m
//  Viinikoodi
//
//  Created by Teemu Harju on 18.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Wine.h"


@implementation Wine

@dynamic alkoID;
@dynamic ean;
@dynamic name;
@dynamic country;
@dynamic region;
@dynamic type;
@dynamic grapes;
@dynamic price;
@dynamic desc;
@dynamic alkoURL;
@dynamic alkoImageURL;
@dynamic isFavourite;
@dynamic scanned;
@dynamic notes;
@dynamic bottleImage;
@dynamic bottleImageData;

- (void)awakeFromFetch
{
    [super awakeFromFetch];
    
    UIImage *bottleImage = [UIImage imageWithData:[self bottleImageData]];
    [self setPrimitiveValue:bottleImage forKey:@"bottleImage"];
}

@end

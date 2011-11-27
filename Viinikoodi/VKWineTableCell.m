//
//  VKWineTableCell.m
//  Viinikoodi
//
//  Created by Teemu Harju on 16.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VKWineTableCell.h"

@implementation VKWineTableCell

@synthesize wineName, wineDescription, winePrice, wineImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

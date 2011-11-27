//
//  VKWineTableCell.h
//  Viinikoodi
//
//  Created by Teemu Harju on 16.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VKWineTableCell : UITableViewCell
{
    IBOutlet UILabel *wineName;
    IBOutlet UILabel *wineDescription;
    IBOutlet UILabel *winePrice;
    IBOutlet UIImageView *wineImage;
}

@property (nonatomic, retain) IBOutlet UILabel *wineName;
@property (nonatomic, retain) IBOutlet UILabel *wineDescription;
@property (nonatomic, retain) IBOutlet UILabel *winePrice;
@property (nonatomic, retain) IBOutlet UIImageView *wineImage;

@end
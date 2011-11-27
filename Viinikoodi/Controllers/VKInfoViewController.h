//
//  VKInfoViewController.h
//  Viinikoodi
//
//  Created by Teemu Harju on 12.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Wine.h"

@interface VKInfoViewController : UIViewController
{
    Wine *wine;
}

@property (nonatomic, retain) IBOutlet UILabel *wineNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *wineTypeLabel;
@property (nonatomic, retain) IBOutlet UILabel *winePriceLabel;
@property (nonatomic, retain) IBOutlet UILabel *wineDescLabel;
@property (nonatomic, retain) IBOutlet UIImageView *wineImageView;

@property (nonatomic, retain) Wine *wine;


- (id)initWithWine:(Wine *)wine;

@end

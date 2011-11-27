//
//  VKInfoViewController.m
//  Viinikoodi
//
//  Created by Teemu Harju on 12.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VKInfoViewController.h"

@implementation VKInfoViewController

@synthesize wine, wineNameLabel, wineTypeLabel, winePriceLabel, wineDescLabel, wineImageView;

- (id)initWithWine:(Wine *)wineModel
{
    self = [super initWithNibName:@"VKWineInfoView" bundle:nil];
    if (self) {
        self.wine = wineModel;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.wineImageView.image = self.wine.bottleImage;
    self.wineNameLabel.text = self.wine.name;
    self.wineTypeLabel.text = [NSString stringWithFormat:@"%@, %@, %@", self.wine.type, self.wine.region, self.wine.country];
    
    self.winePriceLabel.text = [NSString stringWithFormat:@"€ %@",[self.wine.price stringValue]];
    self.wineDescLabel.text = self.wine.desc;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end

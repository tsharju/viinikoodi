//
//  VKWineTableController.m
//  Viinikoodi
//
//  Created by Teemu Harju on 15.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VKWineTableController.h"
#import "VKWineStore.h"
#import "VKWineTableCell.h"
#import "Wine.h"

@implementation VKWineTableController

- (id)init
{
    self = [super initWithStyle:UITableViewStylePlain];
    if (self) {
        self.title = @"Viinit";
        self.tabBarItem.image = [UIImage imageNamed:@"142-wine-bottle"];
        self.tableView.rowHeight = 130;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    return [self init];
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
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[VKWineStore defaultStore] allWines] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellID = @"wineInfoCell";
    
    VKWineTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"VKWineTableCell" owner:nil options:nil];
        
        for (id currentObject in nibObjects) {
            if ([currentObject isKindOfClass:[VKWineTableCell class]]) {
                cell = (VKWineTableCell *)currentObject;
            }
        }
    }
    
    Wine *wine = [[[VKWineStore defaultStore] allWines] objectAtIndex:[indexPath row]];
    cell.wineName.text = wine.name;
    cell.wineDescription.text = [NSString stringWithFormat:@"%@, %@, %@", wine.type, wine.region, wine.country];
    cell.winePrice.text = [NSString stringWithFormat:@"€ %@", [wine.price stringValue]];
    cell.wineImage.image = wine.bottleImage;
    return cell;
}

@end

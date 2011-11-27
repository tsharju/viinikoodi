//
//  WineCoderWineListController.m
//  WineCoder
//
//  Created by Teemu Harju on 15.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "VKWineListController.h"

#import "Wine.h"

//#import "VKWineStore.h"

//#import "VKWineListCell.h"

@implementation VKWineListController

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
    /*UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell"];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"UITableViewCell"] autorelease];
    }*/
    
    static NSString *cellID = @"wineInfoCell";
    
    VKWineListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if (cell == nil)
    {
        NSLog(@"Cell created");
        
        NSArray *nibObjects = [[NSBundle mainBundle] loadNibNamed:@"WineCoderWineListCell" owner:nil options:nil];
        
        for (id currentObject in nibObjects) {
            if ([currentObject isKindOfClass:[WineCoderWineListCell class]]) {
                cell = (VKWineListCell *)currentObject;
            }
        }
    }
    
    WineCoderWineModel *wine = [[[WineCoderWineStore defaultStore] allWines] objectAtIndex:[indexPath row]];
    cell.wineName.text = wine.name;
    cell.wineDescription.text = [NSString stringWithFormat:@"%@, %@, %@", wine.type, wine.region, wine.country];
    cell.winePrice.text = [NSString stringWithFormat:@"€ %@", wine.price];
    cell.wineImage.image = wine.image;
    return cell;
}

@end

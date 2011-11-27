//
//  VKScanViewController
//  Viinikoodi
//
//  Created by Teemu Harju on 12.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

#import "VKScanViewController.h"
#import "VKInfoViewController.h"
#import "VKWineStore.h"

#import "Wine.h"

#import "SBJson.h"

@implementation VKScanViewController

@synthesize readerView, resultCode, resultCodeLabel, activityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Lue koodi";
        self.tabBarItem.image = [UIImage imageNamed:@"195-barcode"];
    }
    return self;
}
							
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.navigationController.navigationBarHidden = YES;
    
    readerView.readerDelegate = self;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    readerView.torchMode = AVCaptureTorchModeOff;
    [readerView start];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
    [readerView stop];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    if (interfaceOrientation == UIInterfaceOrientationPortrait)
        return YES;
    return NO;
}

- (void) readerView: (ZBarReaderView*) view
     didReadSymbols:(ZBarSymbolSet *)symbols
          fromImage:(UIImage *)image
{
    for (ZBarSymbol *symbol in symbols) {
        self.resultCode = symbol.data;
        self.resultCodeLabel.text = symbol.data;
        break;
    }
    
    [activityIndicator startAnimating];

    
    [self performSelector:@selector(loadWineInfo) withObject:nil afterDelay: 0.01];
}

- (void)loadWineInfo
{
    // load JSON data for the wine
    SBJsonParser *parser = [[SBJsonParser alloc] init];
    NSString *fullURL = [NSString stringWithFormat:@"http://www.viinikoodi.fi/haku.php?lang=fi&koodi=%@&out=json", self.resultCode];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:fullURL]];
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *jsonString = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    NSMutableDictionary *wineInfo = [parser objectWithString:jsonString error:nil];
        
    // load image data for the wine
    NSURL *imageURL = [NSURL URLWithString:[wineInfo valueForKey:@"image_url"]];
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    
    [wineInfo setValue:data forKey:@"image_data"];
    
    // get or create the wine object
    int alkoID = [[wineInfo valueForKey:@"alko_id"] intValue];
    Wine *wine = nil;
    if (!(wine = [[VKWineStore defaultStore] fetchWineWithAlkoID:alkoID])) {
        wine = [[VKWineStore defaultStore] createWineFromDict:wineInfo];
    }
    
    [parser release];
    
    UIImage *image = [UIImage imageWithData:data];
    wine.bottleImage = image;
    
    [activityIndicator stopAnimating];
    
    VKInfoViewController *infoController = [[VKInfoViewController alloc] initWithWine:wine];
    infoController.navigationItem.title = @"Viinin tiedot";
    
    [self.navigationController pushViewController:infoController animated:YES];
    [infoController release];
}

- (IBAction)flashButtonTapped:(id)sender
{
    if (readerView.torchMode) {
        readerView.torchMode = AVCaptureTorchModeOff;
        [sender setSelected:NO];
        [sender setImage:[UIImage imageNamed:@"64-zap.png"] forState:UIControlStateNormal];
    } else {
        readerView.torchMode = AVCaptureTorchModeOn;
        [sender setSelected:YES];
        [sender setImage:[UIImage imageNamed:@"64-zap-white.png"] forState:UIControlStateSelected];
    }
}

@end

//
//  VKSecondViewController.h
//  Viinikoodi
//
//  Created by Teemu Harju on 12.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZBarSDK.h"

@interface VKScanViewController : UIViewController <ZBarReaderViewDelegate>
{
    ZBarReaderView *readerView;
    UILabel *resultCodeLabel;
    UIActivityIndicatorView *activityIndicator;
    NSString *resultCode;
}

@property (nonatomic, retain) IBOutlet ZBarReaderView *readerView;
@property (nonatomic, retain) IBOutlet UILabel *resultCodeLabel;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, retain) NSString *resultCode;

- (void)loadWineInfo;
- (IBAction)flashButtonTapped:(id)sender;

@end

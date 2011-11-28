//
//  VKInputProductCodeViewController.h
//  Viinikoodi
//
//  Created by Teemu Harju on 27.11.2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//



@interface VKInputProductCodeViewController : UIViewController <UITextFieldDelegate>
{
    NSString *barcodeResult;
}

@property (nonatomic, retain) IBOutlet UILabel *barcodeLabel;
@property (nonatomic, retain) IBOutlet UITextField *productCodeTextField;
@property (nonatomic, retain) NSString *barcodeResult;

- (id)initWithBarcode:(NSString *)barcode;

- (IBAction)cancelButtonTapped:(id)sender;
- (IBAction)saveButtonTapped:(id)sender;

@end

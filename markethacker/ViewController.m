//
//  ViewController.m
//  markethacker
//
//  Created by Honglai Zhan on 15/10/24.
//  Copyright (c) 2015年 Honglai Zhan. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeReaderViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (IBAction)startBuySomething:(id)sender {
    NSLog(@"clicked start button");
    
    NSArray *types = @[AVMetadataObjectTypeQRCode];
    QRCodeReaderViewController* _reader = [QRCodeReaderViewController readerWithMetadataObjectTypes:types];
    
    _reader.modalPresentationStyle = UIModalPresentationFormSheet;
    
    _reader.delegate = self;
    
    [_reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%@", resultAsString);
        }];
    }];
    [self presentViewController:_reader animated:YES completion:NULL];
}
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

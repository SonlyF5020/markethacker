//
//  ViewController.m
//  markethacker
//
//  Created by Honglai Zhan on 15/10/24.
//  Copyright (c) 2015年 Honglai Zhan. All rights reserved.
//

#import "ViewController.h"
#import "QRCodeReaderViewController.h"
#import "AFHTTPRequestOperationManager.h"
#import "GoodsDetailViewController.h"

@interface ViewController ()

@property (weak, nonatomic) NSDictionary *scannedGoods;

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
            NSLog(@"resulrAsString is %@", resultAsString);
            [self loadGoodsDetail:@"6920202888883"];
        }];
    }];
    [self presentViewController:_reader animated:YES completion:NULL];
}
- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"preparing data");
    if ([segue.identifier compare:@"productDetailSegue"]== NSOrderedSame) {
        [[NSUserDefaults standardUserDefaults] setObject:_scannedGoods forKey:@"currentGoods"];
        GoodsDetailViewController *goodsDetailController = (GoodsDetailViewController*) segue.destinationViewController;
    }
}

- (void) loadGoodsDetail:(NSString *)goodsId {
    NSLog(@"goodsId is %@", goodsId);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *loadUrl = [NSString stringWithFormat:@"https://markethacker.herokuapp.com/products/%@",goodsId];
    NSLog(@"%@", loadUrl);
    [manager GET:loadUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSLog(@"JSON response: %@", responseObject);
        _scannedGoods = responseObject;
        [self performSegueWithIdentifier:@"productDetailSegue" sender:self];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error){
        NSLog(@"Error: %@", error);
    }];
}

@end

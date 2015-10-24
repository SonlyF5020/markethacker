//
//  GoodsDetailViewController.m
//  markethacker
//
//  Created by Honglai Zhan on 15/10/24.
//  Copyright (c) 2015年 Honglai Zhan. All rights reserved.
//

#import "GoodsDetailViewController.h"
#import "UIImageView+WebCache.h"

@interface GoodsDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *goodsName;
@property (weak, nonatomic) IBOutlet UILabel *goodsPrice;
@property (weak, nonatomic) IBOutlet UILabel *goodsDescription;
@property (weak, nonatomic) IBOutlet UIImageView *goodsPicture;

@end

@implementation GoodsDetailViewController
- (IBAction)addToShoppingCart:(id)sender {
    NSMutableArray *shoppingCart = [[NSUserDefaults standardUserDefaults] objectForKey:@"shoppingCart"];
    if (shoppingCart == nil) {
        NSLog(@"%@", @"first time add goods");
        NSMutableArray *initShoppingCart = [[NSMutableArray alloc] init];
        [initShoppingCart addObject:_goods];
        [[NSUserDefaults standardUserDefaults] setObject:initShoppingCart forKey:@"shoppingCart"];
    } else {
        NSLog(@"%@", @"add additional goods");
        NSMutableArray *newShoppingCart = shoppingCart;
        [newShoppingCart addObject:_goods];
        [[NSUserDefaults standardUserDefaults] setObject:newShoppingCart forKey:@"shoppingCart"];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self performSegueWithIdentifier:@"shoppingCartSegue" sender:self];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"JSON is %@", _goods);
    _goods = [[NSUserDefaults standardUserDefaults] objectForKey:@"currentGoods"];
    _goodsName.text = [_goods objectForKey:@"name"];
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    _goodsPrice.text = [formatter stringFromNumber:[_goods objectForKey:@"price"]];
    _goodsDescription.text = [_goods objectForKey:@"desc"];
    NSDictionary *avatarDictionary = [_goods objectForKey:@"avatar"];
    NSString *avatarURL = [NSString stringWithFormat:@"https://markethacker.herokuapp.com%@",[avatarDictionary objectForKey:@"url"]];
    NSLog(@"avatar url here : %@", avatarURL);
    [_goodsPicture sd_setImageWithURL:[NSURL URLWithString:avatarURL] placeholderImage:[UIImage imageNamed:@"default_goods_picture"]];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

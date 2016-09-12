//
//  ConfirmPayOrderViewController.h
//  WeChatPayDemo
//
//  Created by pioneer on 16/8/16.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConfirmPayOrderViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *weixinPay;
@property (weak, nonatomic) IBOutlet UIButton *zhifubaoPay;
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;
@end

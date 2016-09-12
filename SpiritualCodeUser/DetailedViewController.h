//
//  DetailedViewController.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/3.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DetailedViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *headlinLb;


- (instancetype)initWithHeadName:(NSString *)headName;
- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;
@end

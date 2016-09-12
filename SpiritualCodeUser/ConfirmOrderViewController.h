//
//  ConfirmOrderViewController.h
//  ConfirmOrderDemo
//
//  Created by pioneer on 16/8/3.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject
@property (nonatomic, assign) float price;
@property (nonatomic, copy) NSString *subject;
@property (nonatomic, copy) NSString *body;
@property (nonatomic, copy) NSString *orderId;
@end



@interface ConfirmOrderViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *headLB;
- (instancetype)initWithHeadName:(NSString *)headName;

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;
@end

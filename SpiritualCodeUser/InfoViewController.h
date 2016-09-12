//
//  InfoViewController.h
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface InfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *infoScrollView;
@property (weak, nonatomic) IBOutlet UILabel *currentPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *beforePriceLabel;

- (IBAction)commitBtn:(id)sender;


- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic;
@end

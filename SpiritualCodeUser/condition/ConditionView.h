//
//  ConditionView.h
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/17.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ConditionView;
@protocol ConditionViewDelegate <NSObject>

- (void)conditionView:(ConditionView *)conditionView withSelectIndex:(int)index;
@end


@interface UIButton (UIButtonImageWithLable)
- (void) setImage:(UIImage *)image withTitle:(NSString *)title forState:(UIControlState)stateType;
@end

@interface ConditionView : UIView
@property (nonatomic,assign) id<ConditionViewDelegate> delegate;
- (void)outerControlWithIndex:(int)index;
@end

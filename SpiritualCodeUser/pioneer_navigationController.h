//
//  pioneer_navigationController.h
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EaseUI/UIViewController+DismissKeyboard.h>
@class pioneer_navigationController;
typedef NS_ENUM(NSInteger, PioneerBarButtonType) {
    PioneerBarButtonTypeNotify = 0,       //通知
    PioneerBarButtonTypeBack,             //返回
    PioneerBarButtonTypeModel,             //模态
    PioneerBarButtonTypeSearch,            //搜索
    PioneerBarButtonTypeHidden,            //隐藏
    PioneerBarButtonTypeLogin              //注册
};
@protocol pioneer_navigationControllerDelegate <NSObject>
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType) barButtonType;
@end
@interface pioneer_navigationController : UIViewController
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UIView *pioneer_navBar;
@property (strong, nonatomic) UIView *topView;
@property (nonatomic, assign) PioneerBarButtonType barButtonType;
@property (nonatomic, assign) id<pioneer_navigationControllerDelegate> pioneerDelegate;
- (void)setStatusHidden:(BOOL)isHidden;
@end

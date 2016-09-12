//
//  PhotoCollectionViewCell.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/24.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoBrowserHelper/PhotoDisplayHelper.h"

@interface PhotoCollectionViewCell : UICollectionViewCell
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIView *background;
@property (strong, nonatomic) PhotoDisplayHelper *photoDisplayHelper;
@property (strong, nonatomic)  NSArray *imagearr;
- (void)tapAction;
@end

//
//  PhotoDisplayHelper.h
//  PhotoDemo
//
//  Created by pioneer on 16/8/29.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MWPhotoBrowser;
@interface PhotoDisplayHelper : NSObject
- (instancetype)initWithImages:(NSArray *)images withIndex:(short)index;
- (MWPhotoBrowser *)pioneer_browserVC;
@end

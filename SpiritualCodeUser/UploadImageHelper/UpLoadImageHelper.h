//
//  UpLoadImageHelper.h
//  ParamDemo
//
//  Created by pioneer on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Singleton.h"
@class UpLoadImageHelper;
@protocol UpLoadImageHelperDelegate <NSObject>
- (void)uploadImageHelper:(UpLoadImageHelper *)helper andImageUrls:(NSArray *)array;//上传后结果回调
@end

@interface UpLoadImageHelper : NSObject
@property (nonatomic, assign) id<UpLoadImageHelperDelegate> delegate;
- (instancetype)initWithImages:(NSArray *)images;//多张图片上传
- (void)pioneer_beginUpload;//开始上传
- (instancetype)initWithImage:(UIImage *)image;//单张图片上传

@end


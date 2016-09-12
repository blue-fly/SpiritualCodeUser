//
//  CarousePhotoView.h
//  UI_MRC下封装轮播图
//
//  Created by sxz on 16/3/7.
//  Copyright © 2016年 sun. All rights reserved.
//
#import <UIKit/UIKit.h>

@protocol CarouselPictureDelegate <NSObject>

- (void)pushWithUrl:(NSString *)url;

@end

@interface CarousePhotoView : UIView

@property(nonatomic, assign)CGFloat timeInterval;
@property(nonatomic, retain)NSMutableArray *imageUrlArr;
@property(nonatomic, retain)NSMutableArray *urlArr;
@property(nonatomic, assign)id <CarouselPictureDelegate> delegate;
/**
 *  初始化方法
 *
 *  @param frame        大小
 *  @param timeInterval 轮播图时间间隔
 *  @param imageUrlArr  装有轮播图网址的数组
 *  @param urlArr       装有拼接每张轮播图网址的参数的数组
 *
 *  @return 任意对象
 */
- (id)initWithFrame:(CGRect)frame timeInterval:(CGFloat)timeInterval imageUrlArr:(NSArray <NSURL*> *)imageUrlArr urlArr:(NSArray *)urlArr;

@end

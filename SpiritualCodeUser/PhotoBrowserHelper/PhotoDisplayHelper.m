//
//  PhotoDisplayHelper.m
//  PhotoDemo
//
//  Created by pioneer on 16/8/29.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PhotoDisplayHelper.h"
#import <MWPhotoBrowser.h>

@interface PhotoDisplayHelper ()<MWPhotoBrowserDelegate>
{
    short _index;
}
@property (strong, nonatomic) NSMutableArray *pioneer_photoImages;
@property (strong, nonatomic) MWPhotoBrowser *pioneer_browser;
@end

@implementation PhotoDisplayHelper
- (instancetype)initWithImages:(NSArray *)images withIndex:(short)index
{
    if (self = [self init]) {
        _index = index;
       //添加数据
        for (NSString *imageName in images) {
            [self.pioneer_photoImages addObject:[MWPhoto photoWithImage:[UIImage imageNamed:imageName]]];
        }
        
    }
    return self;
}
-(NSMutableArray *)pioneer_photoImages
{
    if(!_pioneer_photoImages){
        _pioneer_photoImages = [NSMutableArray new];
    }
    return _pioneer_photoImages;
}
-(MWPhotoBrowser *)pioneer_browser
{
    _pioneer_browser = [[MWPhotoBrowser alloc]initWithDelegate:self];
    [_pioneer_browser setCurrentPhotoIndex:_index];
    _pioneer_browser.alwaysShowControls = NO;
    return _pioneer_browser;
}
- (MWPhotoBrowser *)pioneer_browserVC
{
    return self.pioneer_browser;
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.pioneer_photoImages.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.pioneer_photoImages.count) {
        return [self.pioneer_photoImages objectAtIndex:index];
    }
    return nil;
}
@end

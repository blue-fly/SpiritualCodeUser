//
//  UpLoadImageHelper.m
//  ParamDemo
//
//  Created by pioneer on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "UpLoadImageHelper.h"

#import "HTTPManager.h"


static UpLoadImageHelper *_pioneer_uploadImageHelper = nil;
@interface UpLoadImageHelper ()
{
    int _image_count;
    NSArray *_pioneer_images;
}
@property (strong, nonatomic) NSMutableArray *image_array;
@end


@implementation UpLoadImageHelper

//images (UIImage set)
- (instancetype)initWithImages:(NSArray *)images
{
    if (self = [super init]) {
        _image_count = 0;
        _pioneer_images = images;
    }
    return self;
}
- (instancetype)initWithImage:(UIImage *)image
{
    if (self = [self initWithImages:@[image]]) {
        
    }
    return self;
}
-(NSMutableArray *)image_array
{
    if(!_image_array){
        _image_array = [NSMutableArray new];
    }
    return _image_array;
}
//根据结果回调
//结果通知
//一个循环的回调，一个结果的回调
- (void)pioneer_beginUpload
{

    
    if (_image_count == _pioneer_images.count) {
        //上传结束
        _image_count = 0;
        //回调
        if (_delegate) {
            if ([_delegate respondsToSelector:@selector(uploadImageHelper:andImageUrls:)]) {
                [_delegate uploadImageHelper:self andImageUrls:self.image_array];
            }
        }
        return;
    }
    
    if (_image_count == 0) {
        [self.image_array removeAllObjects];
    }
    //最后一次调用
    [self next_upload];
    
}
- (void)next_upload
{
    NSData *imageData = UIImageJPEGRepresentation(_pioneer_images[_image_count], 1);
    NSLog(@"imageData  %d",_image_count);
    NSDictionary *dic = @{@"type":@"1",@"file":[NSString stringWithFormat:@"%d.jpg",_image_count++]};
    __weak typeof(self) weakSelf = self;
    //- (void)httpManager:(NSString *)requestURL parameter:(id)param   requestType:(HTTPType)type complectionBlock:(Completion)complection;
    [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/user/oneFileUp" parameter:dic postData:imageData requestType:HTTPTypeUpLoad complectionBlock:^(id responseData, NSError *error) {
        __strong typeof(weakSelf) strongSelf = weakSelf;
        NSString *respMsg = responseData[@"respMsg"];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:[respMsg dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:nil];
        NSDictionary *dicOther = array[0];
        NSString *filePath = dicOther[@"filePath"];
        filePath =  [[filePath componentsSeparatedByString:@"/xlmm/tomcat-7.0.37/webapps/ROOT/"] lastObject];
        filePath = [@"http://121.42.165.80/" stringByAppendingString:filePath];
        if([@"100000" isEqualToString:responseData[@"respCode"]])
        {
            [strongSelf.image_array addObject:filePath];
            [strongSelf pioneer_beginUpload];
        }
        //上传失败暂不考虑
    }];

}
- (void)dealloc
{

}
@end

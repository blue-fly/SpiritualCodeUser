//
//  HTTPManager.h
//  PartTimeMusic
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 pioneer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>
#import "Singleton.h"
typedef NS_ENUM(NSInteger, HTTPType) {
    HTTPTypeGet = 0,   //get请求
    HTTPTypePost,      //post请求
    HTTPTypeForm,       //表单
    HTTPTypeUpLoad      //上传图片
};
//返回数据
typedef void(^Completion)(id responseData , NSError *error);

@interface HTTPManager : NSObject
//单例模式
singleton_h(HTTPManager)
// 数据请求的AFNetworking封装
// requestURL  请求URI
// param
- (void)httpManager:(NSString *)requestURL parameter:(id)param   requestType:(HTTPType)type complectionBlock:(Completion)complection;


- (void)httpManager:(NSString *)requestURL parameter:(id)param postData:(NSData *)data requestType:(HTTPType)type complectionBlock:(Completion)complection;
@end

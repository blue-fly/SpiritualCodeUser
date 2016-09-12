//
//  HTTPManager.m
//  PartTimeMusic
//
//  Created by mac on 16/4/19.
//  Copyright © 2016年 pioneer. All rights reserved.
//

#import "HTTPManager.h"

@implementation HTTPManager
//单例实现
singleton_m(HTTPManager)
- (void)httpManager:(NSString *)requestURL parameter:(id)param   requestType:(HTTPType)type complectionBlock:(Completion)complection
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
//    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    
    if (!complection) {
        //信息提示block未实现
        return;
    }
    switch (type) {
        case HTTPTypeGet:
        {
//            get请求
            [[manager GET:requestURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            请求数据回调
                complection(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            请求出错
                complection(nil,error);
            }]resume];
        }
            break;
        case HTTPTypePost:
        {
//            post请求
            [[manager POST:requestURL parameters:param progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//            请求数据回调
                complection(responseObject,nil);
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//            请求出错
                complection(nil,error);
            }]resume];
        }
            break;
        case HTTPTypeForm:
        {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSString *sessionid = [defaults objectForKey:@"jeesite.session.id"];
            NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL  URLWithString:requestURL]];
            NSString *firstString = @"jeesite.session.id=";
            firstString = [firstString stringByAppendingString:sessionid];
            [request setValue:firstString forHTTPHeaderField:@"Cookie"];
            NSString *aString = [self prepareParam:param];
            request.HTTPMethod = @"POST";
            request.HTTPBody = [aString dataUsingEncoding:NSUTF8StringEncoding];
            [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
                //成功
                if (responseObject) {
                    complection(responseObject,nil);
                }
                //失败
                if (error) {
                    complection(nil,error);
                }
            }]resume];

        }
            break;
            default:
            break;
    }
}

- (void)httpManager:(NSString *)requestURL parameter:(id)param  postData:(id)data requestType:(HTTPType)type complectionBlock:(Completion)complection
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html",nil];
    if (type == HTTPTypeUpLoad) {
        //文件上传
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *sessionid = [defaults objectForKey:@"jeesite.session.id"];
        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL  URLWithString:requestURL]];
        NSString *firstString = @"jeesite.session.id=";
        firstString = [firstString stringByAppendingString:sessionid];
        [request setValue:firstString forHTTPHeaderField:@"Cookie"];
        //分界线的标识符
        NSString *TWITTERFON_FORM_BOUNDARY = @"AaB03x";
        //分界线 --AaB03x
        NSString *MPboundary=[[NSString alloc]initWithFormat:@"--%@",TWITTERFON_FORM_BOUNDARY];
        //结束符 AaB03x--
        NSString *endMPboundary=[[NSString alloc]initWithFormat:@"%@--",MPboundary];
        //要上传的图片
//        UIImage *image= [UIImage imageNamed:[param objectForKey:@"file"]];
        //得到图片的data
//        NSData* data = UIImagePNGRepresentation(image);
        //        data = UIImageJPEGRepresentation(image, 1);
        //http body的字符串
        NSMutableString *body=[[NSMutableString alloc]init];
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:param];
        [dic setObject:firstString forKey:@"Cookie"];
        NSLog(@"dic   %@",dic);
        //参数的集合的所有key的集合
        NSArray *keys= [param allKeys];
        //遍历keys
        for(int i=0;i<[keys count];i++)
        {
            //得到当前key
            NSString *key=[keys objectAtIndex:i];
            //如果key不是pic，说明value是字符类型，比如name：Boris
            if(![key isEqualToString:@"file"])
            {
                //添加分界线，换行
                [body appendFormat:@"%@\r\n",MPboundary];
                //添加字段名称，换2行
                [body appendFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key];
                //添加字段的值
                [body appendFormat:@"%@\r\n",[dic objectForKey:key]];
            }
        }
        ////添加分界线，换行
        [body appendFormat:@"%@\r\n",MPboundary];
        //声明pic字段，文件名为boris.png
        [body appendFormat:@"Content-Disposition: form-data; name=\"file\"; filename=\"boris.jpg\"\r\n"];
        //声明上传文件的格式
        [body appendFormat:@"Content-Type: image/jpg\r\n\r\n"];
        //声明结束符：--AaB03x--
        NSString *end=[[NSString alloc]initWithFormat:@"\r\n%@",endMPboundary];
        //声明myRequestData，用来放入http body
        NSMutableData *myRequestData=[NSMutableData data];
        //将body字符串转化为UTF8格式的二进制
        [myRequestData appendData:[body dataUsingEncoding:NSUTF8StringEncoding]];
        //将image的data加入
        [myRequestData appendData:data];
        //加入结束符--AaB03x--
        [myRequestData appendData:[end dataUsingEncoding:NSUTF8StringEncoding]];
        //设置HTTPHeader中Content-Type的值
        NSString *content=[[NSString alloc]initWithFormat:@"multipart/form-data; boundary=%@",TWITTERFON_FORM_BOUNDARY];
        //设置HTTPHeader
        [request setValue:content forHTTPHeaderField:@"Content-Type"];
        //设置Content-Length
        [request setValue:[NSString stringWithFormat:@"%zd", [myRequestData length]] forHTTPHeaderField:@"Content-Length"];
        //设置http body
        [request setHTTPBody:myRequestData];
        //http method
        [request setHTTPMethod:@"POST"];
        [request setValue:firstString forHTTPHeaderField:@"Cookie"];
        NSLog(@"%@",request.allHTTPHeaderFields);
        [[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
            //成功
            if (responseObject) {
                complection(responseObject,nil);
            }
            //失败
            if (error) {
                complection(nil,error);
            }
        }]resume];
        
    }
}


- (NSString *)prepareParam:(NSDictionary *)paramDic
{
    __block NSString *param = @"";
    [paramDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        NSString *string = [NSString stringWithFormat:@"%@=%@&",key,obj];
        param = [param stringByAppendingString:string];
    }];
    param = [param stringByReplacingCharactersInRange:NSMakeRange(param.length - 1, 1) withString:@""];
    return param;
}
@end

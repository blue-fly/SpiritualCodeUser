//
//  ModelTool.m
//  PartTimeMusic
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 pioneer. All rights reserved.
//

#import "ModelTool.h"

@interface ModelTool ()
@property (weak, nonatomic) NSDictionary *toolDic;
@end

@implementation ModelTool
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    if (self = [self init]) {
        if (_toolDic == nil) {
            _toolDic = dictionary;
        }
        NSLog(@"tag   %@",dictionary[@"title"]);
        [self setValuesForKeysWithDictionary:dictionary];
    }
    return self;
}
+ (instancetype)initModelWithDictionary:(NSDictionary *)dictionary
{
    return [[self alloc]initWithDictionary:dictionary];
}
+ (NSArray *)getModelArrayWithDictionaryArray:(NSArray *)dictionaryArray
{
    NSMutableArray *muArray = [NSMutableArray new];
    for (NSDictionary *dictionary in dictionaryArray) {
        id model = [self initModelWithDictionary:dictionary];
        [muArray addObject:model];
    }
    return muArray;
}
- (void)printModelFormatAttribute
{

    NSString *addParamFormat = @"@property (nonatomic, copy) NSString *%@;\n";
    NSMutableArray *array = [NSMutableArray array];
    [_toolDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [array addObject:[NSString stringWithFormat:addParamFormat,key]];
    }];
    NSString *contentString = @"";
    for (NSString *string  in array) {
        contentString = [contentString stringByAppendingString:string];
    }
    NSLog(@"\n%@",contentString);
    array = nil;
    _toolDic = nil;
}
@end

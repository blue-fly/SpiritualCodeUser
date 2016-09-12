//
//  ModelTool.h
//  PartTimeMusic
//
//  Created by mac on 16/4/20.
//  Copyright © 2016年 pioneer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ModelTool : NSObject
+ (instancetype)initModelWithDictionary:(NSDictionary *)dictionary;
+ (NSArray *)getModelArrayWithDictionaryArray:(NSArray *)dictionaryArray;
- (void)printModelFormatAttribute;
@end

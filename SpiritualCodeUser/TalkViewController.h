//
//  TalkViewController.h
//  SpiritualCode
//
//  Created by pioneer on 16/7/1.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "EaseMessageViewController.h"
@interface TalkViewController : EaseMessageViewController<EaseMessageViewControllerDelegate,EaseMessageViewControllerDataSource,EMChatToolbarDelegate,EaseChatBarMoreViewDelegate>

- (instancetype)initWithConversationChatter:(NSString *)chatter conversationType:(EMConversationType)type  WithDictionryWithModel:(NSDictionary *)modelDic;
@end

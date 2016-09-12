//
//  CustomCell.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/10.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "CustomCell.h"
#import <EaseUI.h>
#import "EMGifImage.h"
#import "UIImageView+HeadImage.h"
#import "EMBubbleView+Gif.h"
@implementation CustomCell
+ (void)initialize
{
    // UIAppearance Proxy Defaults
}

#pragma mark - IModelCell

- (BOOL)isCustomBubbleView:(id<IMessageModel>)model
{
    BOOL flag = NO;
    switch (model.bodyType) {
        case eMessageBodyType_Text:
        {
            if ([model.message.ext objectForKey:@"em_emotion"]) {
                flag = YES;
            }
        }
            break;
        default:
            break;
    }
    return flag;
}

- (void)setCustomModel:(id<IMessageModel>)model
{
    if ([model.message.ext objectForKey:@"em_emotion"]) {
        UIImage *image = [EMGifImage imageNamed:[model.message.ext objectForKey:@"em_emotion"]];
        if (!image) {
            image = model.image;
            if (!image) {
                image = [UIImage imageNamed:model.failImageName];
            }
        }
        _bubbleView.imageView.image = image;
        [self.avatarView imageWithUsername:model.nickname placeholderImage:nil];
    }
}

- (void)setCustomBubbleView:(id<IMessageModel>)model
{
    if ([model.message.ext objectForKey:@"em_emotion"]) {
        [_bubbleView setupGifBubbleView];
        
        _bubbleView.imageView.image = [UIImage imageNamed:@"imageDownloadFail"];
    }
}

- (void)updateCustomBubbleViewMargin:(UIEdgeInsets)bubbleMargin model:(id<IMessageModel>)model
{
    if ([model.message.ext objectForKey:@"em_emotion"]) {
        [_bubbleView updateGifMargin:bubbleMargin];
    }
}

+ (NSString *)cellIdentifierWithModel:(id<IMessageModel>)model
{
    if ([model.message.ext objectForKey:@"em_emotion"]) {
        return model.isSender?@"EaseMessageCellSendGif":@"EaseMessageCellRecvGif";
    } else {
        NSString *identifier = [EaseBaseMessageCell cellIdentifierWithModel:model];
        return identifier;
    }
}

+ (CGFloat)cellHeightWithModel:(id<IMessageModel>)model
{
    if ([model.message.ext objectForKey:@"em_emotion"]) {
        return 100;
    } else {
        CGFloat height = [EaseBaseMessageCell cellHeightWithModel:model];
        return height;
    }
}
//对单元格做一些基础的设置
- (void)setCellAppearance
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.hasRead.textColor = [UIColor whiteColor];
    self.hasRead.backgroundColor = [UIColor colorWithRed:110/255.0 green:208/255.0 blue:113/255.0 alpha:1];
    self.hasRead.layer.cornerRadius = 3;
    self.hasRead.layer.masksToBounds = YES;
}
@end

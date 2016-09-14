//
//  UpdateInfoViewController.h
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"

@interface UpdateInfoViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *updateHeadImageView;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;

@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;

@property (weak, nonatomic) IBOutlet UIView *sexRadioButton;

@property (weak, nonatomic) IBOutlet UITextField *ageTextField;

@property (weak, nonatomic) IBOutlet UITextField *areaTextField;

@end

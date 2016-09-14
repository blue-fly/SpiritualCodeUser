//
//  UpdateInfoViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "UpdateInfoViewController.h"

#import "UIImage+RoundedCorner.h"
#import "QRadioButton.h"
#import "TZImagePickerController.h"
#import "UpLoadImageHelper.h"
#import "UIImageView+WebCache.h"
#import "HTTPManager.h"
#import <UIViewController+HUD.h>
#import "UIControl+ActionBlocks.h"

@interface UpdateInfoViewController ()<QRadioButtonDelegate,pioneer_navigationControllerDelegate,TZImagePickerControllerDelegate,UpLoadImageHelperDelegate>
{
    UpLoadImageHelper *_upload;
    
}

@end

@implementation UpdateInfoViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化设置
    [self initView];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = NO;
//    self.view.backgroundColor = [UIColor colorWithRed:0.87 green:0.87 blue:0.87 alpha:1.00];
}

- (void)viewWillDisappear:(BOOL)animated {
//    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
//    self.navigationController.navigationBarHidden = YES;
}


- (void)initView {

    self.title = @"个人资料";
    
    //取出头像url
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSString *url = [defaults objectForKey:@"HeadImageURL"];
    
    [self.headImage sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    
    
    // 自定义导航栏左侧按钮
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0, 7, 30, 30);
    //    leftBtn.backgroundColor = [UIColor orangeColor];
    [leftBtn setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
    //返回点击事件
    [leftBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIBarButtonItem * leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    // 自定义导航栏右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setTitle:@"保存" forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(self.view.width, 7, 53, 30);
//    rightBtn.backgroundColor = [UIColor orangeColor];
    [rightBtn addTarget:self action:@selector(onTap) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    
    //图片圆角
//    UIImage *Image = [self.headImage.image roundedCornerImage:24 borderSize:8];
//    
//    [self.headImage setImage:Image];

    self.headImage.layer.cornerRadius = self.headImage.width * 0.5;
    self.headImage.layer.masksToBounds = YES;
    //给第一行添加点击手势
    //添加手势点击事件
    UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(updateImage:)];
    
    
    [self.updateHeadImageView addGestureRecognizer:tapGesture];
    
    
    //给昵称加上左视图
    UILabel *nickLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 75, 21)];
    [nickLabel setText:@"昵称"];
    [nickLabel setTextAlignment:NSTextAlignmentCenter];
    self.nickNameTextField.leftView = nickLabel;
    self.nickNameTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //性别上加上单选控件
    QRadioButton *radio1 = [[QRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
    radio1.frame = CGRectMake(65, 12, 50, 30);
    [radio1 setTitle:@"男" forState:UIControlStateNormal];
    [radio1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [radio1.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.sexRadioButton addSubview:radio1];
    [radio1 setChecked:YES];
    
    QRadioButton *radio2 = [[QRadioButton alloc]initWithDelegate:self groupId:@"remaind"];
    radio2.frame = CGRectMake(120, 12, 50, 30);
    [radio2 setTitle:@"女" forState:UIControlStateNormal];
    [radio2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [radio2.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.sexRadioButton addSubview:radio2];

    
    //给年龄加上左视图
    UILabel *ageLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 0, 75, 21)];
    [ageLabel setText:@"年龄"];
    [ageLabel setTextAlignment:NSTextAlignmentCenter];
    self.ageTextField.leftView = ageLabel;
    self.ageTextField.leftViewMode = UITextFieldViewModeAlways;
    
    //给地区添加点击手势
    UITapGestureRecognizer *tapGesture2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(areaClick:)];
    
    
    [self.areaView addGestureRecognizer:tapGesture2];
    
}

//点击保存
- (void)onTap {
    
    NSLog(@"点击了保存");
    //上传相关信息
    //id :jeesite.session.usserid
    //Photo :HeadImageURL
    //name :
    
    //判断昵称是否为空
    if (![self.nickNameTextField.text isEqualToString:@""]) {
        
        //获取
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSString *userId = [defaults objectForKey:@"jeesite.session.usserid"];
        NSString *photo = [defaults objectForKey:@"HeadImageURL"];
        
        if (photo == NULL) {
            NSLog(@"请选择头像!");
            return;
        }
        
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setObject:@"" forKey:@"Email"];
        [dict setObject:@"" forKey:@"Phone"];
        [dict setObject:@"" forKey:@"Mobile"];
        [dict setObject:@"" forKey:@"Remarks"];
        [dict setObject:photo forKey:@"Photo"];
        [dict setObject:userId forKey:@"id"];
        [dict setObject:self.nickNameTextField.text forKey:@"name"];
        
        
        [[HTTPManager sharedHTTPManager] httpManager:@"http://121.42.165.80/a/sys/user/update" parameter:dict requestType:HTTPTypeForm complectionBlock:^(NSDictionary * responseData, NSError *error) {
            
            
            [self showHint:responseData[@"respMsg"] yOffset:50];
            
        }];
        
        
        
        
    }
}


//点击修改头像
- (void)updateImage:(UITapGestureRecognizer *)gesture {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 columnNumber:4 delegate:self];
    
    // You can get the photos by block, the same as by delegate.
    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
        //上传图片
        _upload = [[UpLoadImageHelper alloc] initWithImage:photos[0]];
        
        _upload.delegate = self;
        [_upload pioneer_beginUpload];
        
        [self.headImage setImage:photos[0]];
        
        
    }];
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
}

//点击地区
- (void)areaClick:(UITapGestureRecognizer *)gesture {
    
    NSLog(@"点击了地区");
}

//单选
-(void)didSelectedRadioButton:(QRadioButton *)radio groupId:(NSString *)groupId
{
    if ([radio.titleLabel.text isEqualToString:@"男"]) {
        NSLog(@"选中了男");
    }
    if ([radio.titleLabel.text isEqualToString:@"女"]) {
        NSLog(@"选中了女");
    }
    
}

#pragma mark pioneer_navigationController
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark UpLoadImageHelper
- (void)uploadImageHelper:(UpLoadImageHelper *)helper andImageUrls:(NSArray *)array {
    
    //将URL存到NSUserDefault中
    
    NSLog(@"%@",array[0]);
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setObject:array[0] forKey:@"HeadImageURL"];
    
    [defaults synchronize];
    
}

@end

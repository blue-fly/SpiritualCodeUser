//
//  BeautyViewController.m
//  SpiritualCodeUser
//
//  Created by 段登志 on 16/9/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "BeautyViewController.h"
#import "Masonry.h"
#import "TZImagePickerController.h"
#import "UIView+Layout.h"
#import "TZTestCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Photos/Photos.h>
#import "TZImageManager.h"
#import "UIControl+ActionBlocks.h"


#import <UMSocialData.h>
#import <UMSocialWechatHandler.h>
#import <UMSocialSnsService.h>
#import <UMSocialQQHandler.h>
#import <UMSocial.h>

@interface BeautyViewController ()<UITextViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate,TZImagePickerControllerDelegate,UINavigationControllerDelegate,UMSocialUIDelegate> {
    NSMutableArray *_selectedPhotos;
    NSMutableArray *_selectedAssets;
    CGFloat _itemWH;
    CGFloat _margin;
    
    //标题
    UITextField *_titleTextFiled;
    
    NSMutableArray *_imageArr;
}

//自定义placeholder
@property (nonatomic,strong) UILabel *tip;

@property (nonatomic, strong) UIImagePickerController *imagePickerVc;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation BeautyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.97 blue:0.96 alpha:1.00];
    
    
    _imageArr = [NSMutableArray array];
    
    
    
    //设置视图布局
    [self setUpView];
    
    //设置参数
    [self initParam];

    [self setUpNav];
}

- (void)initParam {
    _selectedPhotos = [NSMutableArray array];
    _selectedAssets = [NSMutableArray array];
    
   

    CGFloat rgb = 244 / 255.0;
    _collectionView.alwaysBounceVertical = YES;
    _collectionView.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:1.0];
    _collectionView.contentInset = UIEdgeInsetsMake(4, 4, 4, 4);
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}


- (void)setUpView {
    
    //标题
    _titleTextFiled = [[UITextField alloc] init];
    [self.view addSubview:_titleTextFiled];
    
    _titleTextFiled.placeholder = @"标题（18字以内）";
    _titleTextFiled.backgroundColor = [UIColor whiteColor];
//    titleTextFiled.borderStyle = UITextBorderStyleLine;
    _titleTextFiled.layer.masksToBounds = YES; // 隐藏边界
    _titleTextFiled.layer.borderWidth = 1;  // 给图层添加一个有色边框
    _titleTextFiled.layer.borderColor = [UIColor colorWithRed:0.473 green:0.522 blue:0.507 alpha:1.000].CGColor;
    
    
    [_titleTextFiled mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@0);
        make.right.equalTo(@0);
        make.top.equalTo(@64);
        make.height.equalTo(@60);
        
    }];
    
    //分享内容
    UIView *contentView = [[UIView alloc] init];
    [self.view addSubview:contentView];
    
    contentView.backgroundColor = [UIColor whiteColor];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.right.equalTo(@0);
        make.top.equalTo(_titleTextFiled.mas_bottom).offset(10);
        make.height.equalTo(@200);
        
    }];
    
    
    //内容
    UITextView *contentTextView = [[UITextView alloc]
                                     init];
    [contentView addSubview:contentTextView];
    
//    contentTextView.backgroundColor = [UIColor greenColor];
    
    contentTextView.autocapitalizationType = UITextAutocapitalizationTypeNone;
    contentTextView.font = [UIFont systemFontOfSize:17 weight:-0.15];
    contentTextView.delegate = self;
    
    [contentTextView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@5);
        make.right.equalTo(@-5);
        make.top.equalTo(@5);
        make.height.equalTo(@150);
        
    }];
    
    //自定义文本框placeholder
    self.tip = [[UILabel alloc] init];
    [contentTextView addSubview:self.tip];
    
    self.tip.text = @"今天有什么和大家分享的...";
    
    [self.tip mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(@3);
        make.top.equalTo(@6);
        make.width.equalTo(self.view.mas_width);
        
    }];
    
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    _margin = 4;
    _itemWH = (self.view.tz_width - 2 * _margin - 4) / 3 - _margin;
    layout.itemSize = CGSizeMake(_itemWH, _itemWH);
    layout.minimumInteritemSpacing = _margin;
    layout.minimumLineSpacing = _margin;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    
    [self.view addSubview:_collectionView];
    
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(contentView.mas_bottom);
        make.left.equalTo(@0);
        make.width.equalTo(@(self.view.tz_width));
        make.height.equalTo(@(self.view.tz_height - contentView.frame.origin.y));
        
    }];
    
    
    
}


- (void)setUpNav {
    
    self.navigationController.navigationBarHidden = NO;
    
    //    self.view.backgroundColor = [UIColor colorWithRed:0.24 green:0.75 blue:0.82 alpha:1.00];
    
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
    
    //中间title
    self.title = @"美丽秀";
    
    
    
    // 自定义导航栏右侧按钮
    UIButton * rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, self.view.width - 20, 60, 60);
    [rightBtn setTitle:@"分享" forState:UIControlStateNormal];
    
    //返回分享事件
    [rightBtn handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        [[UMSocialData defaultData].urlResource setResourceType:UMSocialUrlResourceTypeImage url:@"http://www.baidu.com/img/bdlogo.gif"];
        [UMSocialData defaultData].extConfig.title = @"分享的title";
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://baidu.com";
        [UMSocialSnsService presentSnsIconSheetView:self
                                             appKey:@"57a8891b67e58ee737000c76"
                                          shareText:_titleTextFiled.text
                                         shareImage:[UIImage imageNamed:@"icon"]
                                    shareToSnsNames:@[UMShareToWechatSession,UMShareToWechatTimeline]
                                           delegate:self];
        
    }];
    
    UIBarButtonItem * rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    self.view.backgroundColor = [UIColor colorWithRed:0.91 green:0.97 blue:0.95 alpha:1.00];
}

- (UIImagePickerController *)imagePickerVc {
    if (_imagePickerVc == nil) {
        _imagePickerVc = [[UIImagePickerController alloc] init];
        _imagePickerVc.delegate = self;
        // set appearance / 改变相册选择页的导航栏外观
        _imagePickerVc.navigationBar.barTintColor = self.navigationController.navigationBar.barTintColor;
        _imagePickerVc.navigationBar.tintColor = self.navigationController.navigationBar.tintColor;
        UIBarButtonItem *tzBarItem, *BarItem;
        if (iOS9Later) {
            tzBarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[TZImagePickerController class]]];
            BarItem = [UIBarButtonItem appearanceWhenContainedInInstancesOfClasses:@[[UIImagePickerController class]]];
        } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            tzBarItem = [UIBarButtonItem appearanceWhenContainedIn:[TZImagePickerController class], nil];
            BarItem = [UIBarButtonItem appearanceWhenContainedIn:[UIImagePickerController class], nil];
#pragma clang diagnostic pop
        }
        NSDictionary *titleTextAttributes = [tzBarItem titleTextAttributesForState:UIControlStateNormal];
        [BarItem setTitleTextAttributes:titleTextAttributes forState:UIControlStateNormal];
    }
    return _imagePickerVc;
}


#pragma mark textView的代理
//限制字数为240
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if (range.location < 240) {
        return YES;
    }else {
        
        return NO;
    }
    
}

- (void)textViewDidChange:(UITextView *)textView {
    
    
    
    if (textView.text.length == 0)
    {
        self.tip.text = @"您的意见是我们前进的最大动力，谢谢！";
    } else {
        self.tip.text = @"";
    }
    
}

#pragma mark UICollectionView

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AlbumAddBtn.png"];
        cell.deleteBtn.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        cell.asset = _selectedAssets[indexPath.row];
        cell.deleteBtn.hidden = NO;
    }
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == _selectedPhotos.count) {
        [self pushImagePickerController];
    }else {
        
    }
    
    
}

#pragma mark - TZImagePickerController

- (void)pushImagePickerController {
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];

    // 你可以通过block或者代理，来得到用户选择的照片.
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];

}

#pragma mark - TZImagePickerControllerDelegate
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    _selectedAssets = [NSMutableArray arrayWithArray:assets];
    [_collectionView reloadData];
   
}

- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset {
    _selectedPhotos = [NSMutableArray arrayWithArray:@[coverImage]];
    _selectedAssets = [NSMutableArray arrayWithArray:@[asset]];
    
    [_collectionView reloadData];
   
}


#pragma mark Click Event

- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_selectedAssets removeObjectAtIndex:sender.tag];
    
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}
@end

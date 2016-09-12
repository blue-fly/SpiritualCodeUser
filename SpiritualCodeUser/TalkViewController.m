//
//  TalkViewController.m
//  SpiritualCode
//
//  Created by pioneer on 16/7/1.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "TalkViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import <IQKeyboardReturnKeyHandler.h>
#import <IQKeyboardManager.h>
#import "CustomCell.h"
#import "NSObject+EaseMobAddDelegate.h"
#import "ParticularViewController.h"
#import "MyLocationViewController.h"
//#import "EaseMessageViewController.h"
#import "EaseMessageReadManager.h"

#import "NSObject+Runtime.h"

@interface TalkViewController ()<EaseMessageCellDelegate>
{
    NSDictionary *_stepDicModel;
}
@property (strong, nonatomic) UIView *pioneer_barView;
@property (strong, nonatomic) UILabel *pioneer_titleLB;
@property (strong, nonatomic) UILabel *titleLB;
@property (strong, nonatomic) UIView *pioneer_navBar;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) EaseChatToolbar *toolBar;
@property (strong, nonatomic) UIButton *notifyButton;
@property (strong, nonatomic) UIView *statusBgView;      //状态条背景条
@property (strong, nonatomic) UIButton *deleteBtn;       //信息删除按钮
@property (strong, nonatomic) UIView *networkStateView;  //网络状态


@end

@implementation TalkViewController

- (instancetype)initWithDictionryWithModel:(NSDictionary *)modelDic {
    if (self = [super init]) {
        _stepDicModel = modelDic; //传值字典
    }
    return self;

}
- (instancetype)initWithConversationChatter:(NSString *)chatter conversationType:(EMConversationType)type  WithDictionryWithModel:(NSDictionary *)modelDic
{
    if (self = [super initWithConversationChatter:chatter conversationType:type]) {
        _stepDicModel = modelDic;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.returnKeyHandler = [[IQKeyboardReturnKeyHandler alloc]initWithViewController:self];
    [self isConnection:[[EaseMob sharedInstance].chatManager isConnected]];
    [self registerEaseMobNotification];
    
    
    //利用runtime方法将定位替换成自己的方法
    [NSObject replaceMethod:@selector(_locationMessageCellSelected:) fromClass:[EaseMessageViewController class]];
    
    //移除
    for (int i = 0; i < 2; i++) {
        [self.chatBarMoreView removeItematIndex:3];
    }
    [[EaseBaseMessageCell appearance] setSendBubbleBackgroundImage:[[UIImage imageNamed:@"chat_sender_bg"] stretchableImageWithLeftCapWidth:5 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setRecvBubbleBackgroundImage:[[UIImage imageNamed:@"chat_receiver_bg"] stretchableImageWithLeftCapWidth:35 topCapHeight:35]];
    [[EaseBaseMessageCell appearance] setAvatarCornerRadius:15];
    [self.view addSubview:self.pioneer_navBar];
    self.titleLB.text = @"会话中";
    [self.pioneer_navBar addSubview:self.notifyButton];
    [self.view addSubview:self.statusBgView];
    [IQKeyboardManager sharedManager].keyboardDistanceFromTextField = 0;
    [IQKeyboardManager sharedManager].enable = NO;
    [self keyboardNotification];
    [self tableViewDidTriggerHeaderRefresh];
    self.view.backgroundColor = [UIColor whiteColor];
    _toolBar.delegate = self;
    self.delegate = self;
    self.dataSource = self;
    self.showRefreshHeader = YES;

    [self.view addSubview:self.pioneer_barView];
    [self.pioneer_navBar addSubview:self.deleteBtn];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [IQKeyboardManager sharedManager].enable = YES;
}
#pragma mark 懒加载
-(UIView *)pioneer_navBar
{
    if(!_pioneer_navBar){
        _pioneer_navBar = [UIView new];
        _pioneer_navBar.backgroundColor = [UIColor colorWithRed:0.00 green:0.77 blue:0.84 alpha:1.00];
    }
    return _pioneer_navBar;
}


-(UILabel *)titleLB
{
    if(!_titleLB){
        _titleLB = [UILabel new];
        _titleLB.textAlignment = NSTextAlignmentCenter;
        _titleLB.textColor = [UIColor whiteColor];
        [_pioneer_navBar addSubview:_titleLB];
        _titleLB.sd_layout.topSpaceToView(_pioneer_navBar,10).leftSpaceToView(_pioneer_navBar,50).rightSpaceToView(_pioneer_navBar,50).bottomSpaceToView(_pioneer_navBar,10);
    }
    return _titleLB;
}
-(UIButton *)notifyButton
{
    if(!_notifyButton){
        _notifyButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_notifyButton setImage:[UIImage imageNamed:@"bar_back"] forState:UIControlStateNormal];
        @weakify(self);
        [[_notifyButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
            @strongify(self);
            if (self.deleteConversationIfNull) {
                //判断当前会话是否为空，若符合则删除该会话
                EMMessage *message = [self.conversation latestMessage];
                if (message == nil) {
                    [[EaseMob sharedInstance].chatManager removeConversationByChatter:self.conversation.chatter deleteMessages:NO append2Chat:YES];
                }
            }

            [self.navigationController popViewControllerAnimated:YES];
    }];
    }
    return _notifyButton;
}
-(UIView *)statusBgView
{
    if(!_statusBgView){
        _statusBgView = [UIView new];
        _statusBgView.backgroundColor = [UIColor colorWithRed:0.00 green:0.77 blue:0.84 alpha:1.00];
    }
    return _statusBgView;
}
-(UIButton *)deleteBtn
{
    if(!_deleteBtn){
        _deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_deleteBtn setImage:[UIImage imageNamed:@"delete"] forState:UIControlStateNormal];
        @weakify(self);
        [[_deleteBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
           //信息删除
            @strongify(self);
            if (self.dataArray.count == 0) {
                [self showHint:@"没有消息" yOffset:50];
                return ;
            }
            [self.conversation removeAllMessages];
            [self.messsagesSource removeAllObjects];
            [self.dataArray removeAllObjects];
            
            [self.tableView reloadData];
            [self showHint:@"消息已清空" yOffset:50];
        }];
    }
    return _deleteBtn;
}
- (UIView *)networkStateView
{
    if (_networkStateView == nil) {
        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 44)];
        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 20) / 2, 20, 20)];
        imageView.image = [UIImage imageNamed:@"messageSendFail"];
        [_networkStateView addSubview:imageView];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
        label.font = [UIFont systemFontOfSize:15.0];
        label.textColor = [UIColor grayColor];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"网络不给力，请检查网络设置";
        [_networkStateView addSubview:label];
    }
    
    return _networkStateView;
}

#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _pioneer_navBar.sd_layout.topSpaceToView(self.view,20).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(44);
    _notifyButton.sd_layout.topSpaceToView(self.pioneer_navBar,5).leftSpaceToView(self.pioneer_navBar,10).bottomSpaceToView(self.pioneer_navBar,5).widthEqualToHeight();
    _deleteBtn.sd_layout.topSpaceToView(self.pioneer_navBar,5).rightSpaceToView(self.pioneer_navBar,10).bottomSpaceToView(self.pioneer_navBar,5).widthEqualToHeight();
    _statusBgView.sd_layout.topSpaceToView(self.view,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(20);
    self.tableView.sd_layout.topSpaceToView(self.view,69).leftSpaceToView(self.view,0).rightSpaceToView(self.view,0).bottomSpaceToView(self.chatToolbar,0);

}



#pragma mark 协议

- (UITableViewCell *)messageViewController:(UITableView *)tableView cellForMessageModel:(id<IMessageModel>)model
{
    if (model.bodyType == eMessageBodyType_Text || model.bodyType == eMessageBodyType_Image) {
        NSString *CellIdentifier = [CustomCell cellIdentifierWithModel:model];
        //发送cell
        CustomCell *sendCell = (CustomCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        // Configure the cell...
        if (sendCell == nil) {
            sendCell = [[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier model:model];
            [sendCell setCellAppearance];
        }
        sendCell.delegate  =self;
        sendCell.model = model;
        return sendCell;
    }

    
    return nil;

}

#pragma mark - 点击头像跳转

- (void)avatarViewSelcted:(id<IMessageModel>)model {
    
    ParticularViewController *particVC = [[ParticularViewController alloc] initWithDictionryWithModel:_stepDicModel];
    [self.navigationController pushViewController:particVC animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//键盘高度改变时 调整tableView  需要设置偏移量和 大小
//往上边拉会出现问题
- (void)chatToolbarDidChangeFrameToHeight:(CGFloat)toHeight
{
    if(self.tableView.contentSize.height < kContent_Height)
    {
        return;
    }
    if(toHeight > 100)
    [self.tableView  setContentOffset:CGPointMake(0, self.tableView.contentSize.height - kContent_Height + 64 + toHeight)  animated:YES] ;
    return;

//    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:NO];

}


#pragma mark ----通知----
- (void)keyboardNotification{
    NSOperationQueue *mainQueue = [NSOperationQueue mainQueue];
    //键盘上升
    [[NSNotificationCenter defaultCenter] addObserverForName:UIKeyboardFrameEndUserInfoKey object:nil queue:mainQueue usingBlock:^(NSNotification * _Nonnull note) {
        
    }];
}
- (void)didReceiveMessage:(EMMessage *)message
{
    [super didReceiveMessage:message];
    //发送通知，响铃
    NSNotification *notify = [[NSNotification alloc]initWithName:@"bellNotification" object:nil userInfo:nil];
    [[NSNotificationCenter defaultCenter] postNotification:notify];
}
#pragma mark ------判断网络是否连接--------
- (void)isConnection:(BOOL)isConnection
{
    if (!isConnection)
    {
        self.tableView.tableHeaderView = self.networkStateView;
    }
    else
    {
        self.tableView.tableHeaderView = nil;
    }
}
- (void)networkChanged:(EMConnectionState)connectionState
{
    if (connectionState == eEMConnectionDisconnected) {
        self.tableView.tableHeaderView = self.networkStateView;
    }
    else{
        self.tableView.tableHeaderView = nil;
    }
}
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    [self networkChanged:connectionState];
}
- (void)dealloc
{
    [self unRegisterEaseMobNotification];

}


#pragma mark - moreViewLocationAction
- (void)moreViewLocationAction:(EaseChatBarMoreView *)moreView
{
    // Hide the keyboard
    [self.chatToolbar endEditing:YES];
    
    MyLocationViewController *locationController = [[MyLocationViewController alloc] init];
    locationController.delegate = self;
    [self.navigationController pushViewController:locationController animated:YES];
}

#pragma mark - messageCellSelected

//打开地图
- (void)_locationMessageCellSelected:(id<IMessageModel>)model
{
//    _scrollToBottomWhenAppear = NO;
    
    MyLocationViewController *locationController = [[MyLocationViewController alloc] initWithLocation:CLLocationCoordinate2DMake(model.latitude, model.longitude)];
    [self.navigationController pushViewController:locationController animated:YES];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

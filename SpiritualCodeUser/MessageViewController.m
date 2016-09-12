//
//  MessageViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/8.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "MessageViewController.h"
#import "TalkViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "NSObject+EaseMobAddDelegate.h"
#import <EMCDDeviceManager.h>
#import "TwoTableViewCell.h"
#import "InformTableViewCell.h"
@interface MessageViewController ()<UITableViewDataSource,UITableViewDelegate,EaseConversationListViewControllerDelegate,EMChatManagerDelegate>
@property (strong, nonatomic) UIView *pioneer_barView;
@property (strong, nonatomic) UILabel *pioneer_titleLB;
@property (strong, nonatomic) UIView *pioneer_navBar;
@property (strong, nonatomic) UIButton *backBtn;
@property (strong, nonatomic) UIView *statusBgView;      //状态条背
@property (strong, nonatomic) NSDate *lastPlaySoundDate;
@property (strong, nonatomic) UIView *networkStateView;  //网络状态
@property (strong, nonatomic) UITableView *bottomTB;
@end
static const CGFloat kDefaultPlaySoundInterval = 3.0;
@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    [self isConnection:[[EaseMob sharedInstance].chatManager isConnected]];
    [self registerEaseMobNotification];
    //响铃通知提示通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(bellNotification) name:@"bellNotification" object:nil];    self.lastPlaySoundDate = [NSDate date];
    [[EaseMob sharedInstance].chatManager loadAllConversationsFromDatabaseWithAppend2Chat:YES];

    
//    [self.tableView registerClass:[TwoTableViewCell class] forCellReuseIdentifier:@"TwoTableViewCell"];
    
//    UINib *nib = [UINib nibWithNibName:@"InformTableViewCell" bundle:nil];
//    [self.tableView registerNib:nib forCellReuseIdentifier:@"InformTableViewCell"];
//    
    
    [self.view addSubview:self.pioneer_navBar];
    self.pioneer_titleLB.text = @"消息";


    
    [self.view addSubview:self.statusBgView];
    self.showRefreshHeader = YES;
    [self tableViewDidTriggerHeaderRefresh];
    self.delegate = self;
    [self registerEaseMobNotification];
    NSLog(@"tag  %@",self.dataArray);
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self isConnection:[[EaseMob sharedInstance].chatManager isConnected]];
    [self tableViewDidFinishTriggerHeader:YES reload:YES];
}
#pragma mark 懒加载

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count ;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0) {
//        return 10;
//    }
//    else if (indexPath.row == 2) {
//        return 10;
//    }else if(indexPath.row == 1){
//        return 100;
//    }else {
        return 50;
//    };
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (indexPath.row == 0 || indexPath.row == 2) {
//        TwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwoTableViewCell"];
//        return cell;
//    }
//    else if(indexPath.row == 1){
//        InformTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"InformTableViewCell"];
//        return cell;
//    }else
//    {
        return [super tableView:tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row  inSection:0]];
//    }
    
    
}
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if(indexPath.row >= 3)
//    {
        return UITableViewCellEditingStyleDelete;
//    }
//    return UITableViewCellEditingStyleNone;
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(editingStyle == UITableViewCellEditingStyleDelete)
    {
        [super tableView:tableView commitEditingStyle:editingStyle forRowAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
    }
}


-(UIView *)pioneer_navBar
{
    if(!_pioneer_navBar){
        _pioneer_navBar = [UIView new];
        _pioneer_navBar.backgroundColor = UIColorFromRGB(0x3ebed2);
    }
    return _pioneer_navBar;
}

-(UIView *)statusBgView
{
    if(!_statusBgView){
        _statusBgView = [UIView new];
        _statusBgView.backgroundColor = UIColorFromRGB(0x3ebed2);
    }
    return _statusBgView;
}
-(UILabel *)pioneer_titleLB
{
    if(!_pioneer_titleLB){
        _pioneer_titleLB = [UILabel new];
        _pioneer_titleLB.textAlignment = NSTextAlignmentCenter;
        _pioneer_titleLB.textColor = [UIColor whiteColor];
        [_pioneer_navBar addSubview:_pioneer_titleLB];
        _pioneer_titleLB.sd_layout.topSpaceToView(_pioneer_navBar,10).leftSpaceToView(_pioneer_navBar,50).rightSpaceToView(_pioneer_navBar,50).bottomSpaceToView(_pioneer_navBar,10);
    }
    return _pioneer_titleLB;
}
//- (UIView *)networkStateView
//{
//    if (_networkStateView == nil) {
//        _networkStateView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 64)];
//        _networkStateView.backgroundColor = [UIColor colorWithRed:255 / 255.0 green:199 / 255.0 blue:199 / 255.0 alpha:0.5];
//        
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, (_networkStateView.frame.size.height - 40) / 2, 40, 40)];
//        imageView.image = [UIImage imageNamed:@"messageSendFail"];
//        [_networkStateView addSubview:imageView];
//        
//        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 0, _networkStateView.frame.size.width - (CGRectGetMaxX(imageView.frame) + 15), _networkStateView.frame.size.height)];
//        label.font = [UIFont systemFontOfSize:15.0];
//        label.textColor = [UIColor grayColor];
//        label.backgroundColor = [UIColor clearColor];
//        label.text = @"网络不给力，请检查网络设置";
//        [_networkStateView addSubview:label];
//    }
//    
//    return _networkStateView;
//}

#pragma mark 自动布局
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    _pioneer_navBar.sd_layout.topSpaceToView(self.statusBgView,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(44);
    _statusBgView.sd_layout.topSpaceToView(self.view,0).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(20);
    self.tableView.sd_layout.topSpaceToView(self.pioneer_navBar,0).leftEqualToView(self.view).rightEqualToView(self.view).bottomEqualToView(self.view);
  
}

#pragma mark 协议
- (void)conversationListViewController:(EaseConversationListViewController *)conversationListViewController
            didSelectConversationModel:(id<IConversationModel>)conversationModel
{
    //样例展示为根据conversationModel，进入不同的会话ViewController
    if (conversationModel) {
        EMConversation *conversation = conversationModel.conversation;
        TalkViewController *chatController = [[TalkViewController alloc] initWithConversationChatter:conversation.chatter conversationType:conversation.conversationType];
        
        NSLog(@"%@",conversation.chatter);
        
        
        
        id app = [UIApplication sharedApplication].delegate;
        UINavigationController *nav =  (UINavigationController *)[app window].rootViewController;
        [nav pushViewController:chatController animated:YES];
    }
    
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row >= 3) {
        [super tableView:tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForItem:indexPath.row inSection:0]];
//    }
}
-(void)setupUnreadMessageCount
{
    NSArray *conversations = [[[EaseMob sharedInstance] chatManager] conversations];
    NSInteger unreadCount = 0;
    for (EMConversation *conversation in conversations) {
        unreadCount += conversation.unreadMessagesCount;
    }
    if (unreadCount > 0)
    {
        self.navigationController.tabBarItem.badgeValue = [NSString stringWithFormat:@"%i",(int)unreadCount];
    }
    else
    {
        self.navigationController.tabBarItem.badgeValue = nil;
    }
    UIApplication *application = [UIApplication sharedApplication];
    [application setApplicationIconBadgeNumber:unreadCount];
    NSLog(@"unreadCount %@",@(unreadCount));
}
- (void)playSoundAndVibration{
    NSTimeInterval timeInterval = [[NSDate date]
                                   timeIntervalSinceDate:self.lastPlaySoundDate];
    if (timeInterval < kDefaultPlaySoundInterval) {
        //如果距离上次响铃和震动时间太短, 则跳过响铃
        NSLog(@"skip ringing & vibration %@, %@", [NSDate date], self.lastPlaySoundDate);
        return;
    }
    
    //保存最后一次响铃时间
    self.lastPlaySoundDate = [NSDate date];
    
    // 收到消息时，播放音频
    [[EMCDDeviceManager sharedInstance] playNewMessageSound];
    // 收到消息时，震动
    [[EMCDDeviceManager sharedInstance] playVibration];
}
- (void)didUnreadMessagesCountChanged
{
    [self setupUnreadMessageCount];
    [self.tableView reloadData];
}
-(void)didReceiveMessage:(EMMessage *)message
{
  NSLog(@"%s",__func__);
    UIApplicationState state = [[UIApplication sharedApplication] applicationState];
        switch (state) {
            case UIApplicationStateActive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateInactive:
                [self playSoundAndVibration];
                break;
            case UIApplicationStateBackground:
//                [self showNotificationWithMessage:message];
                break;
            default:
                break;
        }
    [self tableViewDidTriggerHeaderRefresh];
}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [self unRegisterEaseMobNotification];
}
#pragma mark ----响铃通知-------
- (void)bellNotification
{
    [self playSoundAndVibration];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [self unRegisterEaseMobNotification];
}
- (void)didConnectionStateChanged:(EMConnectionState)connectionState
{
    [self networkChanged:connectionState];
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

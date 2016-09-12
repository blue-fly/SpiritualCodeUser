//
//  SeekViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/16.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SeekViewController.h"
#import "PlasticCell.h"

@interface SeekViewController ()<UITableViewDelegate, UITableViewDataSource,pioneer_navigationControllerDelegate>
@property (strong, nonatomic) UITableView *bottomTB;
@property (strong, nonatomic) NSMutableArray *dataArr;
@end

@implementation SeekViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"搜索";
    self.pioneerDelegate = self;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bottomTB];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _bottomTB.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
    
}

- (void)data {
    [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/cms/article/list?keywords=%@", self.key] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
        _dataArr = responseData;
        
    }];
}

- (UITableView *)bottomTB {
    if (!_bottomTB) {
        _bottomTB = [UITableView new];
        _bottomTB.delegate = self;
        _bottomTB.dataSource = self;
        
        UINib *nib = [UINib nibWithNibName:@"PlasticCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"PlasticCell"];
        
    }
    return _bottomTB;
}

- (NSMutableArray *)dataArr {
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    PlasticCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PlasticCell"];
    return cell;
}
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

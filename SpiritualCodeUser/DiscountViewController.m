//
//  DiscountViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "DiscountViewController.h"
#import "DiscountTableViewCell.h"
@interface DiscountViewController ()<pioneer_navigationControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *bottomTB;
@end

@implementation DiscountViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"抢购";
    self.pioneerDelegate =self;
    // Do any additional setup after loading the view.
    [self.view addSubview:self.bottomTB];
}


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    
    _bottomTB.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 0, 0));
}

- (UITableView *)bottomTB {
    if (!_bottomTB) {
        self.bottomTB = [UITableView new];
        _bottomTB.delegate = self;
        _bottomTB.dataSource =self;
        UINib *nib = [UINib nibWithNibName:@"DiscountTableViewCell" bundle:nil];
        [_bottomTB registerNib:nib forCellReuseIdentifier:@"DiscountTableViewCell"];
        
        
    }
    return _bottomTB;
    
}

- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType {
    [self.navigationController popViewControllerAnimated:YES];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 120;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DiscountTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DiscountTableViewCell"];
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

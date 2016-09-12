//
//  SearchViewController.m
//  SpiritualCodeUser
//
//  Created by pioneer on 16/7/13.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "SearchViewController.h"
#import "SeekViewController.h"

@interface SearchViewController ()<pioneer_navigationControllerDelegate,UISearchBarDelegate>

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong, nonatomic) pioneer_navigationController *pioVC;

@end

@implementation SearchViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"搜索";
    self.pioneerDelegate = self;
    

    
    

    
    [self.view addSubview:self.searchBar];
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    _searchBar.sd_layout.topSpaceToView(self.view, 64).widthRatioToView(self.view,1).heightIs(40);
}
- (UISearchBar *)searchBar {
    if (!_searchBar) {
        self.searchBar = [UISearchBar new];
        
        [self.searchBar setPlaceholder:@"你想搜点啥"];
        
        [self.searchBar setBarStyle:UIBarStyleDefault];
        
        [self.searchBar setTranslucent:YES];
        
        self.searchBar.showsScopeBar = YES;
        
        _searchBar.delegate = self;
        
        
        
        [self.searchBar setShowsCancelButton:YES];
        
//        设置取消
        for (UIView *view in [[_searchBar.subviews lastObject] subviews]) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *cancelBtn = (UIButton *)view;
                [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
            }
        }
        

    }
    return _searchBar;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    SeekViewController *seekVC = [[SeekViewController alloc] init];
    
    seekVC.key = _searchBar.text;
    
    [self.navigationController pushViewController:seekVC animated:YES];
    
    

}


#pragma mark -------------协议-------------
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end

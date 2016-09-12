//
//  YLSearchViewController.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "YLSearchViewController.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
@interface YLSearchViewController ()<pioneer_navigationControllerDelegate>
@property (strong, nonatomic) UIView *entryView;   //词条View
@property (strong, nonatomic) UILabel *dajiaLB;  //大家都在搜
@property (strong, nonatomic) UIButton *buttonOne; //词条button
@property (strong, nonatomic) UIButton *buttonTwo;
@property (strong, nonatomic) UIButton *buttonThree;
@property (strong, nonatomic) UIButton *buttonFour;
@property (strong, nonatomic) UIButton *buttonFive;
@property (strong, nonatomic) UIButton *buttonSix;

@end

@implementation YLSearchViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.barButtonType = PioneerBarButtonTypeBack;
    self.titleLB.text = @"搜索";
    self.pioneerDelegate = self;

    
    //配置searchbar
    mySearchBar = [UISearchBar new];
    mySearchBar.delegate = self;
    [mySearchBar setPlaceholder:@"请输入关键字"];
    
    searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:mySearchBar contentsController:self];
    searchDisplayController.active = NO;
    searchDisplayController.searchResultsDataSource = self;
    searchDisplayController.searchResultsDelegate = self;
    
    
    
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.tableHeaderView = mySearchBar;
    

    
    [self.view addSubview:mySearchBar];
    [self.view addSubview:self.entryView];
    [self.entryView addSubview:self.dajiaLB];
    [self.entryView addSubview:self.buttonOne];
    [self.entryView addSubview:self.buttonTwo];
    [self.entryView addSubview:self.buttonThree];
    [self.entryView addSubview:self.buttonFour];
   }


- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    mySearchBar.sd_layout.topSpaceToView(self.view,64).widthRatioToView(self.view,1).heightIs(30);
    
    _entryView.sd_layout.topSpaceToView(mySearchBar,0).widthRatioToView(self.view,1).heightRatioToView(self.view,0.25);
    _dajiaLB.sd_layout.topSpaceToView(self.entryView,5).leftSpaceToView(_entryView,5).heightIs(10).widthRatioToView(self.view,1.0/3);
    
//    _buttonOne.sd_layout.topSpaceToView(_dajiaLB,5).leftSpaceToView
    
}


- (UIView *)entryView {
    if (!_entryView) {
        self.entryView = [UIView new];
        _entryView.backgroundColor = [UIColor grayColor];
    }
    return _entryView;
}
- (UILabel *)dajiaLB {
    if (!_dajiaLB) {
        self.dajiaLB = [UILabel new];
        _dajiaLB.text = @"大家都在搜";
    }
    return _dajiaLB;
    
}

- (UIButton *)buttonOne {
    if (!_buttonOne) {
        
        self.buttonOne = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buttonOne setTitle:@"美白针" forState:UIControlStateNormal];
        [_buttonOne addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _buttonOne;
}

- (UIButton *)buttonTwo {
    if (!_buttonTwo) {
        
        self.buttonTwo = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buttonTwo setTitle:@"美白针" forState:UIControlStateNormal];
        [_buttonTwo addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _buttonTwo;
}

- (UIButton *)buttonThree {
    if (!_buttonThree) {
        
        self.buttonThree = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buttonThree setTitle:@"美白针" forState:UIControlStateNormal];
        [_buttonThree addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _buttonThree;
}

- (UIButton *)buttonFour {
    if (!_buttonFour) {
        
        self.buttonFour = [UIButton buttonWithType:UIButtonTypeSystem];
        [_buttonFour setTitle:@"美白针" forState:UIControlStateNormal];
        [_buttonFour addTarget:self action:@selector(LogButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _buttonOne;
}





#pragma mark -------------协议-------------
- (void)pioneer_navigationController:(pioneer_navigationController *)navigationController withPioneerBarButtonType:(PioneerBarButtonType)barButtonType
{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        return searchResults.count;
    }
    else {
        return self.serchArray.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //配置两种不同的行背景颜色
    if (indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor whiteColor];
    }else {
        cell.backgroundColor = [UIColor colorWithRed:170/255. green:178/255. blue:190/255. alpha:1.];
    }
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.textLabel.text = searchResults[indexPath.row];
    }
    else {
        cell.textLabel.text = self.serchArray[indexPath.row];
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        return 40;
    }else {
        return 30;
    }
}

#pragma mark -- 搜索结果点击的后的传值逻辑
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        
        //进行了搜索，把搜索选择的结果传出
        [self.delegate searchResultData:searchResults[indexPath.row]];
        
    }else {
        
        //如果没有搜索直接点击的某一行....
        [self.delegate searchResultData:self.serchArray[indexPath.row]];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    searchResults = [[NSMutableArray alloc]init];
    if (mySearchBar.text.length > 0 && ![ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (int i = 0; i < self.serchArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:self.serchArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:self.serchArray[i]];
                NSRange titleResult = [tempPinYinStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [searchResults addObject:self.serchArray[i]];
                }
                NSString *tempPinYinHeadStr = [PinYinForObjc chineseConvertToPinYinHead:self.serchArray[i]];
                NSRange titleHeadResult = [tempPinYinHeadStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleHeadResult.length>0) {
                    [searchResults addObject:self.serchArray[i]];
                }
            }
            else {
                NSRange titleResult=[self.serchArray[i] rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.length > 0) {
                    [searchResults addObject:self.serchArray[i]];
                }
            }
        }
    } else if (mySearchBar.text.length > 0 && [ChineseInclude isIncludeChineseInString:mySearchBar.text]) {
        for (NSString *tempStr in self.serchArray) {
            NSRange titleResult = [tempStr rangeOfString:mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length > 0) {
                [searchResults addObject:tempStr];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    //cell的刷新动画
    cell.frame = CGRectMake(-320, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.2 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
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

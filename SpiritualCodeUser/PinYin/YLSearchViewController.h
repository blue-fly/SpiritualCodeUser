//
//  YLSearchViewController.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/7/21.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "pioneer_navigationController.h"
@protocol SearchResultDelegate <NSObject>

- (void)searchResultData:(NSString *)value;//1.1定义协议与方法


@end

@interface YLSearchViewController : pioneer_navigationController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate> {
    NSMutableArray *searchResults;
    UISearchBar *mySearchBar;
    UISearchDisplayController *searchDisplayController;
    
}
//@property (strong, nonatomic) UISearchBar *mySearchBar;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *serchArray;
@property (nonatomic,strong) id <SearchResultDelegate> delegate;


@end

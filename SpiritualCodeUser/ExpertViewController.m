//
//  ExpertViewController.m
//  SpiritualCode
//
//  Created by pioneer on 16/6/26.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "ExpertViewController.h"
#import "ExpertCell.h"
#import "ExpertModel.h"
#import "ExpertDetailViewController.h"
#import "HospitalCell.h"
#import "ConditionView.h"
#import "HosIntroduceViewController.h"
#import "ModelTool.h"
#import "HosModel.h"
#import <ReactiveCocoa/RACEXTScope.h>
#import <EaseMob.h>
#import "TalkViewController.h"

@interface ExpertViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) UITableView *expertTB;        //推荐
@property (strong, nonatomic) UITableView *hotTB;           //最热
@property (strong, nonatomic) UITableView *scaleTB;         //规模
@property (strong, nonatomic) NSArray *dataSource;          //专家数据
//@property (strong, nonatomic) HosModel *hosModel;
@property (strong, nonatomic) NSArray *models;
//@property (strong, nonatomic) ConditionView *conditionView; //选择

@property (strong, nonatomic) NSMutableArray *hosArr;
@property (strong, nonatomic) NSMutableArray *extArr;


@end

@implementation ExpertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.barButtonType = PioneerBarButtonTypeHidden;
    self.titleLB.text = @"机构";
    
     self.models = [NSArray array];
    [self load_testData];

    
    [self.view addSubview:self.expertTB];
    
    
    [self.expertTB setSeparatorInset:UIEdgeInsetsZero];
    [self.expertTB setLayoutMargins:UIEdgeInsetsZero];
    
}
// 数据
- (void)load_testData
{
    
    @weakify(self);
    [[HTTPManager sharedHTTPManager] httpManager:[NSString stringWithFormat:@"http://121.42.165.80/a/noauth/sys/office/list"] parameter:nil requestType:HTTPTypePost complectionBlock:^(id responseData, NSError *error) {
        @strongify(self);
        
        if([responseData isKindOfClass:[NSArray class]])
        {
//          
        }
        
        
    
    
        self.models = [HosModel getModelArrayWithDictionaryArray:responseData];
//        ModelTool *model = [_models objectAtIndex:0];
////        NSLog(@"%@",model.);
//        [model printModelFormatAttribute];
//        
//        for (HosModel *model in self.models) {
//            if ([model.fax isEqualToString:@"10"]) {
//                [self.extArr addObject:model];
//                
//              
//            }else {
//                [self.hosArr addObject:model];
//               
//            
//            }
//        }
        
        [self.expertTB reloadData];

   
        
        
        
    
    }];

    
}


- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
   
    _expertTB.sd_layout.spaceToSuperView(UIEdgeInsetsMake(64, 0, 49, 0));
    

}

-(UITableView *)expertTB
{
    if(!_expertTB){
        _expertTB = [UITableView new];

        _expertTB.rowHeight = 100;
        UINib *nib = [UINib nibWithNibName:@"HospitalCell" bundle:nil];
        
        [_expertTB registerNib:nib forCellReuseIdentifier:@"HospitalCell"];
        
        _expertTB.delegate = self;
        _expertTB.dataSource = self;
        
        
//
    }
    return _expertTB;
}


#pragma mark-----------table view delegate & dataSource----------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

        HospitalCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HospitalCell"];
    cell.hosModel = self.models[indexPath.row];
        [cell setSeparatorInset:UIEdgeInsetsZero];
        [cell setLayoutMargins:UIEdgeInsetsZero];
        return cell;
    
   }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

        return _models.count;

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HosModel *hos = _models[indexPath.row];
#warning "mutal"
    NSMutableDictionary *stepDicModel = [NSMutableDictionary new];
//    (NSMutableDictionary *)ddd
    //模型对象   模型类型
    [stepDicModel setObject:hos forKey:NSStringFromClass([HosModel class])];
    
//    HosIntroduceViewController *vc = [[HosIntroduceViewController alloc] initWithDictionryWithModel:stepDicModel];
    
//    vc.ID = hos.ID;
//    vc.introduceLB = hos.remarks;
//    vc.nameLB = hos.name;
//    vc.addLB = hos.address;
    
    
//    EMConversation *conversation = [[EaseMob sharedInstance].chatManager conversationForChatter:@"13285358328" conversationType:eConversationTypeChat];
    
    
    TalkViewController *vc = [[TalkViewController alloc] initWithConversationChatter:@"13285358328" conversationType:eConversationTypeChat WithDictionryWithModel:stepDicModel];
    
    
    
    [self.tabBarController.navigationController pushViewController:vc animated:YES];

    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    [((HospitalCell *)cell)prepareApprence];
}



//- (void)conditionView:(ConditionView *)conditionView withSelectIndex:(int)index
//{
//    //设置table联动
//    if (index <  2) {
//        [_bottomView setContentOffset:CGPointMake(kContent_Width * index, 0) animated:YES];
//    }
//}
//
////滑动视图以顶部view  联动
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if ([scrollView isEqual:self.bottomView]) {
//        //算偏移量 ----> index
//        int index = scrollView.contentOffset.x / kContent_Width;
//        [_conditionView outerControlWithIndex:index];
//      
//            
//            
//        }
//        
//        
//    }

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

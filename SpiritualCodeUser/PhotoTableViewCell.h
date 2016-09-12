//
//  PhotoTableViewCell.h
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/24.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhotoCollectionViewCell.h"

@interface PhotoTableViewCell : UITableViewCell<UICollectionViewDataSource, UICollectionViewDelegate>
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UILabel *headLB;
@property (strong, nonatomic) NSArray *imageArr;
@end

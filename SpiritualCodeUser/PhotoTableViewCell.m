//
//  PhotoTableViewCell.m
//  SpiritualCodeUser
//
//  Created by SunXZ on 16/8/24.
//  Copyright © 2016年 xlmm. All rights reserved.
//

#import "PhotoTableViewCell.h"


@implementation PhotoTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    
    if (!(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) return nil;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.itemSize = CGSizeMake(60, 60);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.imageArr = @[@"sun", @"1",@"2",@"sun",@"sun",@"sun"];
    self.collectionView.delegate = self;
    self.collectionView.dataSource =self;
    
      [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    
    self.headLB = [UILabel new];
   
    _headLB.text = @"机构图片";
    _headLB.font = [UIFont systemFontOfSize:14];
    _headLB.textAlignment = NSTextAlignmentRight;

    
    
    
    
    [self.contentView addSubview:self.headLB];
    [self.contentView addSubview:self.collectionView];
    
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.collectionView.frame = CGRectMake(60, 0, self.contentView.frame.size.width, self.contentView.frame.size.height);
    self.headLB.frame = CGRectMake(0, 0, 60, self.contentView.frame.size.height);
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return _imageArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
    
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    PhotoCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    cell.imageView.image = [UIImage imageNamed:self.imageArr[indexPath.section]];
    
    cell.imagearr = _imageArr;
    cell.tag = indexPath.section;
    return cell;
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  ThirdTableViewCell.h
//  
//
//  Created by SunXZ on 16/7/24.
//
//

#import <UIKit/UIKit.h>

@protocol ThirdTableViewCellDelegate <NSObject>

- (void)thirdTableViewCellHigh:(CGFloat)text;

@end


@interface ThirdTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *introduceLB;
@property (weak, nonatomic) IBOutlet UIButton *unfoldBth;
@property (nonatomic, assign) CGFloat highCell;
@property (nonatomic, assign) CGSize expectSize;

@property (nonatomic, assign)id<ThirdTableViewCellDelegate> delegate;

@end


//
//  ThirdTableViewCell.m
//  
//
//  Created by SunXZ on 16/7/24.
//
//

#import "ThirdTableViewCell.h"

@implementation ThirdTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    _introduceLB.text = @"在此之后的汉文史籍就就没有了瀛国公赵隰的记载，但在藏文材料中偶有恭帝的踪迹。恭帝十九岁时到喇嘛庙里出家，驻锡萨斯迦大寺，号木波讲师。入吐蕃，学习梵书、西蕃字经。把汉藏佛经互译比勘，校订经书中的异文。后来赵隰还担任了萨迦大寺的住持，法号为“合尊”，成为当时吐蕃的佛学大师，四处讲经，穷其一生潜心研究佛学。他翻译了《百法明门论》，以及佛理深奥的《因明入正理论》，在扉页留下了题字，自称为“大汉王出家僧人合尊法宝”。被藏族史学家列入翻译大师的名单";
    self.highCell = 72;
    
    
}

- (IBAction)unfold:(id)sender {
    
    static BOOL high = YES;
    if (high) {
        
        
//        NSString *str = @"在此之后的汉文史籍就就没有了瀛国公赵隰的记载，但在藏文材料中偶有恭帝的踪迹。恭帝十九岁时到喇嘛庙里出家，驻锡萨斯迦大寺，号木波讲师。入吐蕃，学习梵书、西蕃字经。把汉藏佛经互译比勘，校订经书中的异文。后来赵隰还担任了萨迦大寺的住持，法号为“合尊”，成为当时吐蕃的佛学大师，四处讲经，穷其一生潜心研究佛学。他翻译了《百法明门论》，以及佛理深奥的《因明入正理论》，在扉页留下了题字，自称为“大汉王出家僧人合尊法宝”。被藏族史学家列入翻译大师的名单中偶有恭帝的踪迹。恭帝十九岁时到喇嘛庙里出家，驻锡萨斯迦大寺，号木波讲师。入吐蕃，学习梵书、西蕃字经。把汉藏佛经互译比勘，校订经书中的异文。后来赵隰还担任了萨迦大寺的住持，法号为“合尊”，成为当时吐蕃的佛学大师，四处讲经，穷其一生潜心研究佛学。他翻译了《百法明门论》，以及佛理深奥的《因明入正理论》，在扉页留下了题字，自称为“大汉王出家僧人合尊法宝”。被藏族史学家列入翻译大师的名单";
//        _introduceLB.text = str;
        
        _introduceLB.numberOfLines = 0;//根据最大行数需求来设置
        _introduceLB.lineBreakMode = NSLineBreakByTruncatingTail;
        CGSize maximumLabelSize = CGSizeMake(281, 9999);//labelsize的最大值
        //关键语句
        CGSize expectSize = [_introduceLB sizeThatFits:maximumLabelSize];
        //别忘了把frame给回label，如果用xib加了约束的话可以只改一个约束的值
        _introduceLB.frame = CGRectMake(0, 42, expectSize.width, expectSize.height);
        
        self.highCell = _introduceLB.frame.size.height + 80;
        
        [self.contentView addSubview:self.introduceLB];
        

//        self.introduceLB.numberOfLines = 0;
        
        NSLog(@"############%f",self.introduceLB.frame.size.height);
        
        
        
    }else {
        self.highCell = 120;
        self.introduceLB.numberOfLines = 2;
        
        
    }
    
    high = !high;
    
    if (_delegate) {
        if ([_delegate respondsToSelector:@selector(thirdTableViewCellHigh:)]) {
            [self.delegate thirdTableViewCellHigh:self.highCell];
        }
    }
    
//    UILabel *textLabel = [[UILabel alloc] init];
//    _introduceLB.font = [UIFont systemFontOfSize:16];
    
    NSLog(@"666");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

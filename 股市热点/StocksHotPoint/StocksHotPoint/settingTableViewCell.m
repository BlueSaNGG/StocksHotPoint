//
//  settingTableViewCell.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/7.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "settingTableViewCell.h"

@implementation settingTableViewCell

- (instancetype)init {
    self = [super init];
    if (self) {
        //加入箭头
        UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置-箭头.png"] highlightedImage:[UIImage imageNamed:@"运营-箭头.png"]];
        [arrow setFrame:CGRectMake(self.center.x+150, self.center.y, 40, 40)];
        [self addSubview:arrow];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 25;
    frame.size.width -= 2 * 25;
    [super setFrame:frame];
}

@end

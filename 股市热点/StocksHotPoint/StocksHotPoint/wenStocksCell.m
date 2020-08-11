//
//  wenStocksCell.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/10.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "wenStocksCell.h"
#import <Masonry.h>




@interface wenStocksCell()

@property (nonatomic, strong)UILabel *label;
@property (nonatomic, strong)UIImageView *imgView;

@end

@implementation wenStocksCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andMessageType:(ChatMesageType)messagetype {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.messageType = messagetype; //赋予类型
        if( messagetype == ChatMessageFrom) {
            [self.contentView addSubview:self.imgViewRight];
        } else {
            [self.contentView addSubview:self.imgViewLeft];
        }
        [self.contentView addSubview:self.label];
        //取消点击背景
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont systemFontOfSize:14];
        _label.preferredMaxLayoutWidth = 300;
        [_label setTextAlignment:NSTextAlignmentLeft];
        [_label setNumberOfLines:0];

    }
    return _label;
}

#pragma mark - 靠右气泡
- (UIImageView *)imgViewRight {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        UIImage *backImg = [UIImage imageNamed:@"气泡框1.png"];
        [backImg resizableImageWithCapInsets:UIEdgeInsetsMake(backImg.size.height*0.9, backImg.size.width*0.9, backImg.size.height*0.9, backImg.size.width*0.9) resizingMode:UIImageResizingModeStretch];
        _imgView.image = backImg;
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (void)setStrRight:(NSString *)str {
    _str = str;
    _label.text = _str;
//    _label.backgroundColor = [UIColor redColor];
    [_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label.superview.mas_top).offset(20);
        make.right.equalTo(_label.superview.mas_right).offset(-40);
        make.bottom.equalTo(_label.superview.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];

    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_label).offset(-25);
        make.top.equalTo(_label).offset(-10);
        make.bottom.equalTo(_label).offset(10);
        make.right.equalTo(_label).offset(25);
    }];
}


#pragma mark - 靠左气泡
- (UIImageView *)imgViewLeft {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        UIImage *backImg = [UIImage imageNamed:@"气泡框2.png"];
        [backImg resizableImageWithCapInsets:UIEdgeInsetsMake(backImg.size.height*0.7, backImg.size.width*0.7, backImg.size.height*0.7, backImg.size.width*0.7) resizingMode:UIImageResizingModeStretch];
        _imgView.image = backImg;
        [self.contentView addSubview:_imgView];
    }
    return _imgView;
}

- (void)setStrLeft:(NSString *)str {
    _str = str;
    _label.text = _str;
//    _label.backgroundColor = [UIColor redColor];
    [_label mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_label.superview.mas_top).offset(20);
        make.left.equalTo(_label.superview.mas_left).offset(40);
        make.bottom.equalTo(_label.superview.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-20);
    }];
    
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_label).offset(-25);
        make.top.equalTo(_label).offset(-10);
        make.bottom.equalTo(_label).offset(10);
        make.right.equalTo(_label).offset(25);
    }];
}
@end

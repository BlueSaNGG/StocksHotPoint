//
//  hoursTableViewCell.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "hoursTableViewCell.h"
#import "ListModel.h"


@interface hoursTableViewCell()
@property(nonatomic, copy)NSString *text;
@property(nonatomic, copy)NSString *curTime;
-(void)setLabelSpace:(UILabel*)label withSpace:(CGFloat)space withFont:(UIFont*)font;
@end


@implementation hoursTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    
    
}

- (instancetype)initWithData:(NSDictionary *)Data {
    self = [super init];
        if (self) {
            //标题设置
            _text=Data[@"title"];
            if(_text.length>26) {
                _text = [[_text substringToIndex:26] stringByAppendingString:@"..."];
            }
            //
            self = [self initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:@"id"];
            
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(14, 0, self.bounds.size.width+30, 62)];
            [textLabel setText:_text];
            [textLabel setTextColor:[UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:1.0]];
            textLabel.numberOfLines = 2;
            textLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            [self setLabelSpace:textLabel withSpace:3 withFont:[UIFont systemFontOfSize:16]];
            //设置最多显示字数
//            textLabel.backgroundColor = [UIColor yellowColor];
            
            [self.contentView addSubview:textLabel];
            
            //时间设置
            _curTime = [Data[@"rtime"] substringFromIndex:5];
            _curTime = [_curTime substringToIndex:11];
            
            UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-30, textLabel.center.y+5, 120, 30)];
            [timeLabel setTextColor:[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0]];
            timeLabel.text = _curTime;
            [self setLabelSpace:timeLabel withSpace:3 withFont:[UIFont systemFontOfSize:13]];
            [timeLabel adjustsFontSizeToFitWidth];
            [self addSubview:timeLabel];
            
        }
        return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setLabelSpace:(UILabel*)label withSpace:(CGFloat)space withFont:(UIFont*)font  {
    
        NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
        paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
        paraStyle.alignment = NSTextAlignmentLeft;
        paraStyle.lineSpacing = space; //设置行间距
        paraStyle.hyphenationFactor = 1.0;
        paraStyle.firstLineHeadIndent = 0.0;
        paraStyle.paragraphSpacingBefore = 0.0;
        paraStyle.headIndent = 0;
        paraStyle.tailIndent = 0;
        //设置字间距 NSKernAttributeName:@1.5f
        NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle, NSKernAttributeName:@0.0f
                              };
        NSAttributedString *attributeStr = [[NSAttributedString alloc] initWithString:label.text attributes:dic];
        label.attributedText = attributeStr;
}

@end

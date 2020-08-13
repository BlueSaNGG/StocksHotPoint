//
//  hotDotCell.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "hotDotCell.h"
#import "ListModel.h"

@interface hotDotCell()

@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UILabel *timeLabel;
@property(nonatomic, strong) UILabel *abstractLabel;
@property(nonatomic, strong) UILabel *companyLabel;
@property(nonatomic, strong) UILabel *commentLabel;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *time;
@property(nonatomic, copy) NSString *abstract;
@property(nonatomic, copy) NSString *company;
@property(nonatomic, copy) NSString *comment;
@property(nonatomic, copy) NSString *pic;
@end


@implementation hotDotCell

- (instancetype)initWithData:(NSDictionary *)Data {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"首页-圆角矩形"]];
        [self.backgroundView setContentMode:UIViewContentModeScaleToFill];
        
        //设置标题栏
        _title=Data[@"title"];
        if(_title.length>24) {
                    _title = [[_title substringToIndex:23] stringByAppendingString:@"..."];
                }
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(11, 12, self.bounds.size.width, 40)];
        _titleLabel.text = _title;
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textColor = [UIColor blackColor];
        if(_titleLabel.text) {
        [self setLabelSpace:_titleLabel withSpace:1 withFont:[UIFont systemFontOfSize:16]];
        }
//        _titleLabel.backgroundColor = [UIColor redColor];
        [self addSubview:_titleLabel];
        
        
        //设置pic

        //设置摘要栏
        _abstract = Data[@"summary"];
        _abstractLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y+_titleLabel.frame.size.height+12, _titleLabel.frame.size.width, 50)];
        _abstractLabel.text = _abstract;
        _abstractLabel.numberOfLines = 3;
        _abstractLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        if(_abstractLabel.text) {
        [self setLabelSpace:_abstractLabel withSpace:1 withFont:[UIFont systemFontOfSize:13]];
        }
        [_abstractLabel setTextColor:[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0]];
//        _abstractLabel.backgroundColor = [UIColor yellowColor];
        //判断有无图片
        if(Data[@"pic"]) {
            //创建新线程
            dispatch_queue_global_t downloadQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_main_t mainQueue = dispatch_get_main_queue();
            dispatch_async(downloadQueue, ^{
                //下载图片放在其他线程
                UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:Data[@"pic"]]]];
                dispatch_async(mainQueue, ^{
                    //ui操作放在主线程
                    UIImageView *pic = [[UIImageView alloc] initWithImage:image];
                    [pic setFrame:CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+20, 40, 40)];
                    [self addSubview:pic];
                    [self.abstractLabel setFrame:CGRectMake(pic.bounds.origin.x + 60, self.titleLabel.frame.origin.y+self.titleLabel.frame.size.height+10, self.titleLabel.frame.size.width-60, 50)];
                });
            });
            
        }
        
        [self addSubview:_abstractLabel];
        
        //设置时间
        _time = [[Data[@"ctime"] substringFromIndex:5] substringToIndex:11];;
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.bounds.size.width-80, _titleLabel.bounds.size.height, 80, 30)];
        _timeLabel.textAlignment = NSLayoutAttributeLeft;
        [_timeLabel setTextColor:[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0]];
        _timeLabel.text = _time;
        _timeLabel.font = [UIFont systemFontOfSize:13];
        _timeLabel.adjustsFontSizeToFitWidth = NO;
        [self addSubview:_timeLabel];
        
        //设置公司
        if(Data[@"stocks"]) {
        _company = [@"相关证券：" stringByAppendingString:Data[@"stocks"]];
        }
        _companyLabel = [[UILabel alloc] initWithFrame:CGRectMake(_titleLabel.frame.origin.x, _abstractLabel.frame.origin.y+_abstractLabel.bounds.size.height+9, _titleLabel.frame.size.width, 20)];
        [_companyLabel setTextColor:[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0]];
        _companyLabel.text = _company;
        if(_companyLabel.text) {
        [self setLabelSpace:_companyLabel withSpace:3 withFont:[UIFont systemFontOfSize:11]];
        }
//        _companyLabel.backgroundColor = [UIColor greenColor];
        [self addSubview:_companyLabel];
        
        //设置分割线
        UIImageView *cutLine = [[UIImageView alloc] initWithFrame:CGRectMake(_companyLabel.frame.origin.x, _companyLabel.frame.origin.y+_companyLabel.frame.size.height+9, self.contentView.bounds.size.width, 3)];
        cutLine.image =[UIImage imageNamed:@"首页-点评上分割线.png"];
        [self addSubview:cutLine];
        
        
        //设置点评图标
        UIImageView *commentImg = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 20)];
        commentImg.image =[UIImage imageNamed:@"首页-点评.png"];
        //设置点评栏
        _comment = @"Comment";
        _comment = [@"\u3000\u3000\u3000" stringByAppendingString:_comment];
        _commentLabel = [[UILabel alloc] initWithFrame:CGRectMake(cutLine.frame.origin.x, cutLine.frame.origin.y+cutLine.frame.size.height, _titleLabel.frame.size.width, 20)];
        _commentLabel.text = _comment;
        _commentLabel.numberOfLines = 2;
        _commentLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        [self setLabelSpace:_commentLabel withSpace:2 withFont:[UIFont systemFontOfSize:13]];
        [_commentLabel setTextColor:[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0]];
//        _commentLabel.backgroundColor = [UIColor yellowColor];
        [_commentLabel addSubview:commentImg];
        [self addSubview:_commentLabel];
        
        
        //设置hot图标
        if([Data[@"hot"] isEqualToNumber:@1] ) {
        }
    
    }
    return self;
}

#pragma mark - 重写setframe 调整cell宽度

- (void)setFrame:(CGRect)frame {
    frame.origin.x += 25;
    frame.size.width -= 2 * 25;
    [super setFrame:frame];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - 设置字体和行间距
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

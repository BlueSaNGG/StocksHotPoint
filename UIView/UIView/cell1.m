//
//  cell1.m
//  UIView
//
//  Created by myhexin on 2020/7/30.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "cell1.h"
#import "ListModel.h"

@interface cell1()
@property(nonatomic, strong, readwrite) UILabel *titleLabel;
@property(nonatomic, strong, readwrite) UILabel *sourceLabel;
@property(nonatomic, strong, readwrite) UILabel *commentLabel;
@property(nonatomic, strong, readwrite) UILabel *timeLabel;
@property(nonatomic, strong, readwrite) UIImageView *rightImageView;
@property(nonatomic, strong, readwrite) UIButton *deleteButton;
@end


@implementation cell1

//设置构造函数
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self.contentView addSubview:({
            self.titleLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 15, 270, 50)];
            self.titleLabel.font=[UIFont systemFontOfSize:16];
            self.titleLabel.textColor=[UIColor blackColor];
            self.titleLabel.numberOfLines = 2;
            self.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
            self.titleLabel;
        })];
        [self.contentView addSubview:({
            self.sourceLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 50, 20)];
            self.sourceLabel.font=[UIFont systemFontOfSize:12];
            self.sourceLabel.textColor=[UIColor grayColor];
            self.sourceLabel;
        })];
        [self.contentView addSubview:({
            self.commentLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 70, 50, 20)];
            self.commentLabel.font=[UIFont systemFontOfSize:12];
            self.commentLabel.textColor = [UIColor grayColor];
            self.commentLabel;
        })];
        [self.contentView addSubview:({
            self.timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 70, 50, 20)];
            self.timeLabel.font=[UIFont systemFontOfSize:12];
            self.timeLabel.textColor=[UIColor grayColor];
            self.timeLabel;
        })];
        
        [self.contentView addSubview:({
            self.rightImageView=[[UIImageView alloc] initWithFrame:CGRectMake(300, 15, 100, 70)];
            self.rightImageView.contentMode = UIViewContentModeScaleAspectFit;
            self.rightImageView;
        })];
        
//        [self.contentView addSubview:({
//            self.deleteButton=[[UIButton alloc] initWithFrame:CGRectMake(290, 80, 30, 20)];
//            //设置title的转换
//            [self.deleteButton setTitle:@"X" forState:UIControlStateNormal];
//            [self.deleteButton setTitle:@"V" forState:UIControlStateHighlighted];
//            self.deleteButton.backgroundColor=[UIColor lightGrayColor];
//            //设置button监听的事件与执行的操作
//            [self.deleteButton addTarget:self action:@selector(deleteButtonClick) forControlEvents:UIControlEventTouchUpInside];
//
//            self.deleteButton.layer.cornerRadius = 10;
//            self.deleteButton.layer.masksToBounds = YES;
//
//            self.deleteButton.layer.borderColor = [UIColor grayColor].CGColor;
//            self.deleteButton.layer.borderWidth = 2;
//            self.deleteButton;
//        })];
    }
    return self;
}

- (void)layoutTableViewCellWithItem:(ListModel *)item{
    self.titleLabel.text=item.title;
    self.sourceLabel.text=item.stocks;
    [self.sourceLabel sizeToFit];
    
    self.commentLabel.text=item.summary;
    [self.commentLabel sizeToFit];
    self.commentLabel.frame = CGRectMake(self.sourceLabel.frame.origin.x+ self.sourceLabel.frame.size.width+15, self.commentLabel.frame.origin.y, self.commentLabel.frame.size.width, self.commentLabel.frame.size.height);

    
    self.timeLabel.text=item.ctime;
    [self.timeLabel sizeToFit];
    self.timeLabel.frame = CGRectMake(self.commentLabel.frame.origin.x + self.commentLabel.frame.size.width+15, self.timeLabel.frame.origin.y, self.timeLabel.frame.size.width, self.timeLabel.frame.size.height);
    
    
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:item.pic]]];
    self.rightImageView.image = image;
}


//设置button事件——若点击将当前cell和button都传入delegate——供viewcontroller监听
- (void)deleteButtonClick{
    //若delegate被调用，则传入当前的deletebutton函数
    if(self.delegate && [self.delegate respondsToSelector:@selector(tableViewCell:clickDeleteButton:)]) {
        [self.delegate tableViewCell:self clickDeleteButton:self.deleteButton];
    }
}

@end

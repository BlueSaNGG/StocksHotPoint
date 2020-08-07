//
//  GTDeleteCell.m
//  UIView
//
//  Created by myhexin on 2020/8/3.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "GTDeleteCell.h"
#import <UIKit/UIKit.h>

@interface GTDeleteCell ()
@property(nonatomic, strong) UIView *backgroundView;
@property(nonatomic, strong) UIButton *deleteButton;
@property(nonatomic, copy)  dispatch_block_t deleteBlock;
@end


@implementation GTDeleteCell

#pragma mark - 构造函数
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:({
            _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
            _backgroundView.backgroundColor = [UIColor blackColor];
            _backgroundView.alpha = 0.5;
            [_backgroundView addGestureRecognizer:({
                UITapGestureRecognizer *tapGuesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissDeleteView)];
                tapGuesture;
            })];
            _backgroundView;
        })];
        
        [self addSubview:({
            _deleteButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
            [_deleteButton addTarget:self action:@selector(_clickButton) forControlEvents:UIControlEventTouchUpInside];
            _deleteButton.backgroundColor = [UIColor blueColor];
            _deleteButton;
        })];
        
    }
    return self;
}

#pragma mark - 显示deleteview
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t) clickBlock{
    //给button赋予最初位置
    _deleteButton.frame = CGRectMake(point.x, point.y, 0, 0);
    //deleteblock为传入的block参数
    _deleteBlock = [clickBlock copy];
    
    //将deleteview变为最高view
    [[[UIApplication sharedApplication].windows lastObject] addSubview:self];
    
    //设置deleteview的动画
    [UIView animateWithDuration:0.5f delay:0.f usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.deleteButton.frame = CGRectMake((self.bounds.size.width-200)/2, (self.bounds.size.height-200)/2, 200, 200);
    } completion:^(BOOL finished){
        NSLog(@"shown");
    }];
    
}


#pragma mark - 点击背景
- (void)dismissDeleteView {
    [self removeFromSuperview];
}

#pragma mark - 点击按钮
- (void)_clickButton {
    if(_deleteBlock) {
        _deleteBlock();
    }
    [self removeFromSuperview];
}

@end

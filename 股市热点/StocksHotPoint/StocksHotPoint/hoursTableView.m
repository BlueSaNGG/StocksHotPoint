//
//  hoursTableView.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "hoursTableView.h"


@interface hoursTableView()


@end

//设置数量
@implementation hoursTableView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self setRowHeight:124];
        [self setSeparatorColor:[UIColor colorWithRed:169/255.0 green:169/255.0 blue:169/255.0 alpha:1.0]];
    }
    return self;
}


@end

//
//  hotDotContent.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "hotDotContent.h"


@implementation hotDotContent


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
        [self setRowHeight:189];
        [self setSeparatorColor:[UIColor colorWithWhite:0 alpha:0]];
    }
    return self;
}

@end

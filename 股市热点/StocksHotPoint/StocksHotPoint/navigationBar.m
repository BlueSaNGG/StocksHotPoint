//
//  navigationBar.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "navigationBar.h"

@interface navigationBar ()

@end

@implementation navigationBar

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:240/255.0];
    
    //设置navigationbar
    UIView *navigationBarBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 88)];
    navigationBarBack.backgroundColor = [UIColor redColor];
    
    //设置标题title
    UILabel *navTitle = [[UILabel alloc] init];
    [navTitle setBounds:CGRectMake(0, 0, 200, 44)];
    navTitle.textColor = [UIColor whiteColor];
    navTitle.text = @"股市热点";
    navTitle.font = [UIFont systemFontOfSize:34];
    [navTitle sizeToFit];
    navTitle.center = navigationBarBack.center;
    
    //设置问股按钮
    UILabel *rightBtn = [[UILabel alloc] init];
    [rightBtn setBounds:CGRectMake(0, 0, 200, 44)];
    rightBtn.textColor = [UIColor whiteColor];
    rightBtn.text = @"问股";
    rightBtn.font = [UIFont systemFontOfSize:28];
    [rightBtn sizeToFit];
    rightBtn.center = CGPointMake(self.view.bounds.size.width*6/7.0, navigationBarBack.center.y);
    
    
    UIButton *leftBtn = [[UIButton alloc] init];
    [leftBtn setBounds:CGRectMake(0, 0, 44, 44)];
    // :CGRectMake(0, 0, 44, 44)];
    [leftBtn setImage:[UIImage imageNamed:@"标题栏-设置图标.png"] forState:UIControlStateNormal];
//    [leftBtn setCenter:CGPointMake(self.view.bounds.size.width/7.0, navigationBarBack.center.y)];
    leftBtn.center = navigationBarBack.center;
    
    
    
    
    
    [self.view addSubview:navigationBarBack];
    [self.view addSubview:navTitle];
    [self.view addSubview:rightBtn];
    [self.view addSubview:leftBtn];
}
@end

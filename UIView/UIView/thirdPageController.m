//
//  page3.m
//  UIView
//
//  Created by myhexin on 2020/7/30.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "thirdPageController.h"

@interface thirdPageController ()<UIScrollViewDelegate,UIGestureRecognizerDelegate>

@end

@implementation thirdPageController

-(instancetype)init{
    self=[super init];
    if(self){
        self.tabBarItem.title=@"24小时滚动";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor=[UIColor whiteColor];
    //设置背景色
    NSArray *color = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor yellowColor],[UIColor grayColor]];
    
    //创建scrollview，并设置参数
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.contentSize=CGSizeMake(self.view.bounds.size.width*5, self.view.bounds.size.height);
    scrollView.backgroundColor=[UIColor lightGrayColor];
    scrollView.showsHorizontalScrollIndicator=NO;
    scrollView.pagingEnabled=YES;
    
    //对每一个块设置subview——UIview
    for(int i=0;i<5;i++){
        [scrollView addSubview:({
            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(scrollView.bounds.size.width*i, 0, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            
            [view addSubview:({
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
                view.backgroundColor=[UIColor whiteColor];
                //设置监听的事件和后续的操作
                UITapGestureRecognizer *tapGesture=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewClicked)];
                //设置监听的delegate，对手势操作的生命周期进行监听
                tapGesture.delegate=self;
                //注册手势操作
                [view addGestureRecognizer:tapGesture];
                view;
            })];
            
            [view addSubview:({
                UIView *view=[[UIView alloc] initWithFrame:CGRectMake(100, 250, 250, 250)];
                view.backgroundColor=[UIColor whiteColor];
                view;
            })];
            //加入label
            [view addSubview:({
                UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(110, 260, 200, 150)];
                label.text=@"AlerView";
                label;
            })];
            //加入button
            [view addSubview:({
                UIButton *btn=[[UIButton alloc] initWithFrame:CGRectMake(150, 400, 100, 40)];
                btn.backgroundColor=[UIColor blueColor];
                [btn setTitle:@"click" forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(ClickBtn) forControlEvents:UIControlEventTouchUpInside];
                btn;
            })];
            
            view.backgroundColor=[color objectAtIndex:i];
            view;
        })];
    }
    
    [self.view addSubview:scrollView];
}

-(void) ClickBtn{
    self.navigationItem.title=@"25小时滚动";
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日 HH时mm分ss秒 Z";
    NSLog(@"%@",[formatter stringFromDate:now]);
}

-(void)viewClicked{
    self.tabBarItem.title=@"26小时滚动";
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    return YES;
}

@end

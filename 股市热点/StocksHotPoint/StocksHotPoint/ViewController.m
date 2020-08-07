//
//  ViewController.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/5.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "ViewController.h"
#import "hotDotContent.h"
#import "hotDotCell.h"
#import "hoursTableView.h"
#import "hoursTableViewCell.h"
#import "Webpage.h"
#import "ListLoader.h"
#import "ListModel.h"
#import "settingViewController.h"



@interface ViewController ()
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *leftBtnClicked;
@property(nonatomic, strong) UIView *rightBtnClicked;
@property(nonatomic, strong) UIButton *leftSubBtn;
@property(nonatomic, strong) UIButton *rightSubBtn;
@property(nonatomic, strong) hotDotContent *hotDotTableView;
@property(nonatomic, strong) hoursTableView *hoursTableView;
@property(nonatomic, copy) NSArray *hotDataArray;
@property(nonatomic, strong) NSArray *hoursDataArray;
@property(nonatomic, strong) ListLoader *listLoader;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//全部背景
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:240/255.0];


// - 导航栏设置
//设置按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"标题栏-设置图标.png"] style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked)];
    self.navigationItem.leftBarButtonItem = leftBtn;

//问股按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"问股" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

//title设置
    self.navigationItem.title = @"股市热点";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:34],NSForegroundColorAttributeName:[UIColor whiteColor]}];

//导航栏背景设置
    //设置背景图片——现实backgroundcolor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"标题栏.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];


    
// - 次导航栏设置
    //设置UIview位置
    UIView *subNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 66)];
    subNav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-切换bar-底.png"]];

    //今日热点按钮
    _leftSubBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 144, 60)];
    [_leftSubBtn setTitle:@"热点掘金" forState:UIControlStateNormal];
    [_leftSubBtn setBackgroundImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"] forState:UIControlStateHighlighted];
    _leftSubBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [_leftSubBtn setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0] forState:UIControlStateNormal];
    _leftSubBtn.center = CGPointMake(subNav.center.x/2.0, subNav.center.y);
    
    //24小时滚动按钮
    _rightSubBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 144, 60)];
    [_rightSubBtn setTitle:@"24小时滚动" forState:UIControlStateNormal];
    [_rightSubBtn setBackgroundImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"] forState:UIControlStateHighlighted];
    _rightSubBtn.titleLabel.font = [UIFont systemFontOfSize:22];
    [_rightSubBtn setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0] forState:UIControlStateNormal];
    _rightSubBtn.center = CGPointMake(subNav.center.x*3/2.0, subNav.center.y);
    
// - 添加点击事件
    [_leftSubBtn addTarget:self action:@selector(leftBtnClickedFunc) forControlEvents:UIControlEventTouchUpInside];
    [_rightSubBtn addTarget:self action:@selector(rightBtnClickedFunc) forControlEvents:UIControlEventTouchUpInside];


    [subNav addSubview:_leftSubBtn];
    [subNav addSubview:_rightSubBtn];
    
// - 添加subview
    [self.view addSubview:subNav];
    
    
// - clicked高光设置
    _leftBtnClicked = [[UIView alloc] init];
    _leftBtnClicked.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"]];
    [_leftBtnClicked setBounds:CGRectMake(0, 0, 144, 6)];
    _leftBtnClicked.center = CGPointMake(_leftSubBtn.center.x, _leftSubBtn.center.y+30);
    
    _rightBtnClicked = [[UIView alloc] init];
    _rightBtnClicked.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"]];
    [_rightBtnClicked setBounds:CGRectMake(0, 0, 144, 6)];
    _rightBtnClicked.center = CGPointMake(_rightSubBtn.center.x, _rightSubBtn.center.y+30);
    

//开启时进入今日热点+今日热点高光
    [self.view addSubview:_leftBtnClicked];
    
// - 初始化热点掘金tableview
    _hotDotTableView = [[hotDotContent alloc] initWithFrame:CGRectMake(0, _leftSubBtn.center.y+36, self.view.bounds.size.width, self.view.bounds.size.height)];
    _hotDotTableView.delegate = self;
    _hotDotTableView.dataSource = self;
    [self.view addSubview:_hotDotTableView];
    
// - 初始化24小时滚动tableview
    _hoursTableView = [[hoursTableView alloc] initWithFrame:CGRectMake(0, _leftSubBtn.center.y+36, self.view.bounds.size.width, self.view.bounds.size.height)];
    _hoursTableView.delegate = self;
    _hoursTableView.dataSource = self;


// - 网络请求 热点掘金
    self.listLoader = [[ListLoader alloc] initWithUrl:@"https://m.10jqka.com.cn/todayhot.json"];
    __weak typeof(self) hself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListModel *> * _Nonnull dataArray) {
        __strong typeof(hself) hStrongSelf = hself;
        hStrongSelf.hotDataArray = dataArray;
        [hStrongSelf.hotDotTableView reloadData];
    }];
// - 网络请求 24小时滚动
    self.listLoader = [[ListLoader alloc] initWithUrl:@"https://m.10jqka.com.cn/thsgd_list/index_1.json"];
    __weak typeof(self) wself = self;
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListModel *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.hoursDataArray = dataArray;
        [strongSelf.hoursTableView reloadData];
    }];

}

#pragma mark - 今日热点点击事件
- (void)leftBtnClickedFunc {
    [_rightBtnClicked removeFromSuperview];
    [_hoursTableView removeFromSuperview];
    [self.view addSubview:_leftBtnClicked];
    [self.view addSubview:_hotDotTableView];
}

#pragma mark - 24小时滚动点击事件
- (void)rightBtnClickedFunc {
    [_leftBtnClicked removeFromSuperview];
    [_hotDotTableView removeFromSuperview];
    [self.view addSubview:_rightBtnClicked];
    [self.view addSubview:_hoursTableView];
}

#pragma mark - datasource

//设置section中rows数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _hoursTableView) {
    return 25;
    }
    return 1;
}

//设置每个row中的cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if(tableView == _hoursTableView) {
    hoursTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell) {
        cell = [[hoursTableViewCell alloc] initWithData:_hoursDataArray[indexPath.row]];
        cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    }
    return cell;
    }

    hotDotCell *cell = [tableView dequeueReusableCellWithIdentifier:@"id"];
        if(!cell) {
        cell = [[hotDotCell alloc] initWithData:_hotDataArray[indexPath.section]];
    }
    return cell;

}

#pragma mark - 设置热点界面cell间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if(tableView == _hotDotTableView) {
        return 28;
    }
    return 0;
}

//设置section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView == _hotDotTableView) {
        return 20;
    }
    return 1;
}

//设置每个section的间距
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] init];
    view.backgroundColor = [UIColor clearColor];
    return view;
}



#pragma mark - 页面跳转delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    跳转到webview页面
    if(tableView == self.hoursTableView) {
        ListModel *curData =[self.hoursDataArray objectAtIndex:indexPath.row];
        Webpage *controller = [[Webpage alloc]initWithUrlString:curData.url];
        [self.navigationController pushViewController:controller animated:YES];
    }
    
    if(tableView == self.hotDotTableView) {
        ListModel *curData =[self.hotDataArray objectAtIndex:indexPath.section];
    Webpage *controller = [[Webpage alloc]initWithUrlString:curData.url];
    [self.navigationController pushViewController:controller animated:YES];
    }
}


#pragma mark - 设置按钮事件
- (void) settingClicked {
    [self.navigationController pushViewController:[[settingViewController alloc] init] animated:YES];
}


@end



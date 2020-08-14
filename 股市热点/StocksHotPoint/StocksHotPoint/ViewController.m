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
#import "settingViewController.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "wenStocks.h"
#import <NotificationCenter/NotificationCenter.h>
#import <UserNotifications/UserNotifications.h>
#import <UMCommon/MobClick.h>
#import <MBProgressHUD.h>
#import <WebKit/WebKit.h>

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) UIView *leftBtnClicked;
@property(nonatomic, strong) UIView *rightBtnClicked;
@property(nonatomic, strong) UIButton *leftSubBtn;
@property(nonatomic, strong) UIButton *rightSubBtn;
@property(nonatomic, strong) hotDotContent *hotDotTableView;
@property(nonatomic, strong) hoursTableView *hoursTableView;
@property(nonatomic, copy) NSArray *hotDataArray;
@property(nonatomic, strong) NSMutableArray *hoursDataArray;
@property(nonatomic, assign) int hoursTimes;
@property(nonatomic, strong) wenStocks *wenGuPage;
@property(nonatomic, strong) UIBarButtonItem *rightBtn;
@property(nonatomic, copy) NSString *fileName;
@property(nonatomic, assign) BOOL isAuthToNotify;
@end

@implementation ViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        //初始化dataarrray
        _hoursDataArray = [[NSMutableArray alloc] initWithCapacity:25];
        _hoursTimes = 2;
        _wenGuPage = [[wenStocks alloc] init];
        //设置filename
        NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        _fileName = [path stringByAppendingPathComponent:@"redianjuejin.plist"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//全部背景
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];

// - 导航栏设置
//设置按钮
    UIBarButtonItem *leftBtn = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"标题栏-设置图标.png"] style:UIBarButtonItemStylePlain target:self action:@selector(settingClicked)];
    self.navigationItem.leftBarButtonItem = leftBtn;

//问股按钮
    _rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"问股" style:UIBarButtonItemStylePlain target:self action:@selector(wenStockClicked)];
    self.navigationItem.rightBarButtonItem = _rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

//title设置
    self.navigationItem.title = @"股市热点";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];

//导航栏背景设置
    //设置背景图片——现实backgroundcolor
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"标题栏.png"] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];

// - 次导航栏设置
    //设置UIview位置
    UIView *subNav = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 33)];
    subNav.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-切换bar-底.png"]];

    //今日热点按钮
    _leftSubBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 77, 33)];
    [_leftSubBtn setTitle:@"热点掘金" forState:UIControlStateNormal];
    [_leftSubBtn setBackgroundImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"] forState:UIControlStateHighlighted];
    _leftSubBtn.titleLabel.font = [UIFont systemFontOfSize:14];
    [_leftSubBtn setTitleColor:[UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:1.0] forState:UIControlStateNormal];
    _leftSubBtn.center = CGPointMake(subNav.center.x/2.0, subNav.center.y);
    
    //24小时滚动按钮
    _rightSubBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 77, 33)];
    [_rightSubBtn setTitle:@"24小时滚动" forState:UIControlStateNormal];
    [_rightSubBtn setBackgroundImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"] forState:UIControlStateHighlighted];
    _rightSubBtn.titleLabel.font = [UIFont systemFontOfSize:14];
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
    [_leftBtnClicked setBounds:CGRectMake(0, 0, 72, 6)];
    _leftBtnClicked.center = CGPointMake(_leftSubBtn.center.x, _leftSubBtn.center.y+12);
    
    _rightBtnClicked = [[UIView alloc] init];
    _rightBtnClicked.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"首页-切换bar-选中状态.png"]];
    [_rightBtnClicked setBounds:CGRectMake(0, 0, 72, 6)];
    _rightBtnClicked.center = CGPointMake(_rightSubBtn.center.x, _rightSubBtn.center.y+12 );
    

//开启时进入今日热点+今日热点高光
    [self.view addSubview:_leftBtnClicked];
    
// - 初始化热点掘金tableview
    _hotDotTableView = [[hotDotContent alloc] initWithFrame:CGRectMake(0, _leftSubBtn.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-(_leftSubBtn.center.y+100))];
    _hotDotTableView.delegate = self;
    _hotDotTableView.dataSource = self;
    [self.view addSubview:_hotDotTableView];
//热点掘金头部下拉请求
    _hotDotTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
             //进行网络请求
            [self getHotDot];
         });
    }];

// - 初始化24小时滚动tableview
    _hoursTableView = [[hoursTableView alloc] initWithFrame:CGRectMake(0, _leftSubBtn.bounds.size.height, self.view.bounds.size.width, self.view.bounds.size.height-(_leftSubBtn.center.y+100))];
    _hoursTableView.delegate = self;
    _hoursTableView.dataSource = self;
    
//24小时滚动头部下拉请求
    _hoursTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
             //进行网络请求
             [self getHours];
         });
    }];
    
    
//24小时滚动底部上拉请求
    _hoursTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
             //显示更多的20条页面
             [self getHoursWithTimes];
         });
    }];




    //两个页面全部加入
    [self.view addSubview:_leftBtnClicked];
    [self.view addSubview:_hotDotTableView];
    [self.view addSubview:_rightBtnClicked];
    [self.view addSubview:_hoursTableView];
    //进入页面，执行点击今日热点button事件
    [self leftBtnClickedFunc];
    
    
    //对热点掘金进行一次下拉刷新,判断是否有存储plist文件
    NSArray *result = [NSArray arrayWithContentsOfFile:_fileName];
    if(result) {
        _hotDataArray = result;
        [self.hotDotTableView reloadData];
    } else{
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud.label setText:@"正在连接服务器"];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            [self.hotDotTableView.mj_header beginRefreshing];
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
            });
        });
    }
    
    
    
    //加入notification监听app是否进入前台——进入则刷新24小时滚动界面
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadHours) name:UISceneWillEnterForegroundNotification object:nil];
    
    //加入notification监听app是否进入后台
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(msgNotification) name:UISceneDidEnterBackgroundNotification object:nil];
 
    //接受前台点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(wenStockClicked) name:@"clickedNotificationFront" object:nil];

    //接受后台点击事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mainToWenStocks) name:@"clickedNotificationBack" object:nil];

}

#pragma mark - 删除监听事件
//移除监听事件
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 今日热点点击事件
- (void)leftBtnClickedFunc {
    //点击埋点
    [MobClick event:@"redianjuejin"];
    //隐藏24小时滚动
    [_hoursTableView setHidden:YES];
    [_rightBtnClicked setHidden:YES];
    //点击标题回滚到顶部
    [_hotDotTableView setContentOffset:CGPointMake(0,0) animated:YES];
    //展示热点掘金
    [_leftBtnClicked setHidden:NO];
    [_hotDotTableView setHidden:NO];
}

#pragma mark - 24小时滚动点击事件
- (void)rightBtnClickedFunc {
    //点击埋点
    [MobClick event:@"24roll"];
    //隐藏热点掘金
    [_leftBtnClicked setHidden:YES];
    [_hotDotTableView setHidden:YES];
    //点击标题回滚到顶部
    [_hoursTableView setContentOffset:CGPointMake(0,0) animated:YES];
    //进行刷新+网络请求
    [_hoursTableView.mj_header beginRefreshing];
    //展示24小时滚动
    [_hoursTableView setHidden:NO];
    [_rightBtnClicked setHidden:NO];
}

#pragma mark - datasource

//设置section中rows数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(tableView == _hoursTableView) {
    return [_hoursDataArray count];
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
        return 14;
    }
    return 0;
}

//设置section的数量
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(tableView == _hotDotTableView) {
        return [_hotDataArray count];
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
    //页面跳转点击埋点
    [MobClick event:@"zixun"];
    //点击后颜色变回
     [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    跳转到webview页面
    if(tableView == self.hoursTableView) {
        NSDictionary *curData =[self.hoursDataArray objectAtIndex:indexPath.row];
        Webpage *controller = [[Webpage alloc]initWithUrlString:curData[@"url"]];
    //问股按钮
        controller.navigationItem.rightBarButtonItem = _rightBtn;
        [self.navigationController pushViewController:controller animated:YES];
    }
        if(tableView == self.hotDotTableView) {
        NSDictionary *curData =[self.hotDataArray objectAtIndex:indexPath.section];
    Webpage *controller = [[Webpage alloc]initWithUrlString:curData[@"url"]];
    //问股按钮
    controller.navigationItem.rightBarButtonItem = _rightBtn;
    [self.navigationController pushViewController:controller animated:YES];
    }
}


#pragma mark - 设置按钮事件
- (void) settingClicked {
    //设置点击埋点
    [MobClick event:@"control"];
    [self.navigationController pushViewController:[[settingViewController alloc] init] animated:YES];
}


#pragma mark - 网络请求get
//首次进入请求热点掘金
-(void)getHotDot {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //设置超时时间
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 10;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    [manager GET:@"https://m.10jqka.com.cn/todayhot.json" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.hotDataArray = responseObject[@"pageItems"];
        [self.hotDotTableView reloadData];
        //用plist存储该array
        NSArray *array = self.hotDataArray;
        [array writeToFile:self.fileName atomically:YES];
        [self->_hotDotTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(error.code == -1001) {
            [self refreshFailedWithStr:@"刷新失败"];
        }
        else {
            [self refreshFailedWithStr:@"联网失败，请检查网络"];
        }
        [self->_hotDotTableView.mj_header endRefreshing];
    }];
}

//请求24小时滚动
-(void)getHours {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:@"https://m.10jqka.com.cn/thsgd_list/index_1.json" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.hoursDataArray addObjectsFromArray:responseObject[@"pageItems"]];
        [self.hoursTableView reloadData];
        [self->_hoursTableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self refreshFailedWithStr:@"联网失败，请检查网络"];
        [self->_hoursTableView.mj_header endRefreshing];
    }];
}

//24小时滚动上拉请求
-(void)getHoursWithTimes {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:[NSString stringWithFormat:@"https://m.10jqka.com.cn/thsgd_list/index_%i.json",_hoursTimes] parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [self.hoursDataArray addObjectsFromArray:responseObject[@"pageItems"]];
        [self.hoursTableView reloadData];
        [self->_hoursTableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [self refreshFailedWithStr:@"联网失败，请检查网络"];
        [self->_hoursTableView.mj_footer endRefreshing];
    }];
    _hoursTimes++;
}

#pragma mark - 进入问股页面
- (void)wenStockClicked {
    //问股点击埋点
    [MobClick event:@"wengu"];
    //进入问股页面
    [self.navigationController pushViewController:_wenGuPage animated:YES];
}

#pragma mark - 刷新失败提示语
- (void)refreshFailedWithStr:(NSString *)str {
    //初始化错误提示
    UILabel *failAlert = [[UILabel alloc]init];
    failAlert.font = [UIFont systemFontOfSize:16];
    failAlert.backgroundColor = [UIColor blackColor];
    failAlert.textColor = [UIColor whiteColor];
    [failAlert setText:str];
    [failAlert sizeToFit];
    [failAlert setCenter:CGPointMake(self.view.center.x, self.view.center.y*2/3.0)];
    [self.view addSubview:failAlert];
    [UIView animateWithDuration:2 animations:^{
        failAlert.alpha=0;
    } completion:^(BOOL finished) {
        [failAlert removeFromSuperview];
    }];
       
}

#pragma mark - 请求打开消息推送通知
- (void)viewWillAppear:(BOOL)animated {
    //判断用户是否同意推送
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    self.isAuthToNotify = NO;
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if(granted) {
        self.isAuthToNotify = YES;
        }
    }];
}

#pragma mark - 设置消息推送
- (void)msgNotification{
    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    //创建一个notification
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"股市热点";
    content.subtitle = @"问股";
    content.body = @"您好，有什么需要帮忙的吗？";
    content.sound = [UNNotificationSound defaultSound];
    
    //trigger
    UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:5 repeats:NO];
    //setting up the request for notification
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"UNLocal Notification" content:content trigger:trigger];
    
    if(self.isAuthToNotify) {
    //加入notification
    [center addNotificationRequest:request withCompletionHandler:nil];
    }
}

#pragma mark - 从后台进入app时重新加载24小时滚动
- (void)reloadHours {
    //点击标题回滚到顶部
    [_hoursTableView setContentOffset:CGPointMake(0,0) animated:YES];
    //进行刷新+网络请求
    [_hoursTableView.mj_header beginRefreshing];
}

#pragma mark - 从后台点击推送进入，从首页到问股
- (void)mainToWenStocks {
    [self.navigationController popToRootViewControllerAnimated:NO];
    [self leftBtnClickedFunc];
    [self wenStockClicked];
}
@end




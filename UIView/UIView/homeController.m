//
//  ViewController.m
//  UIView
//
//  Created by myhexin on 2020/7/29.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "homeController.h"
#import "cell1.h"
#import "Webpage.h"
#import "GTDeleteCell.h"
#import "ListLoader.h"
#import "ListModel.h"
#import <MJRefresh.h>
#import <AFNetworking.h>


#pragma mark - 私有变量定义
@interface homeController ()<UITableViewDataSource,UITableViewDelegate, cell1Delegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) ListLoader *listLoader;
-(void)get;
@end



@implementation homeController

#pragma mark - 初始化存储cell的Array
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.tabBarItem.title=@"主页";
    }
    return self;
}


#pragma mark - 设置tableview
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    _tableView.dataSource=self;
    _tableView.delegate=self;
    //上拉刷新
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
       //Call this Block When enter the refresh status automatically
        NSLog(@"refreshed");
    }];
//    或
    // Set the callback（Once you enter the refresh status，then call the action of target，that is call [self loadNewData]）
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];

    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
    // Enter the refresh status immediately
//    [self.tableView.mj_header beginRefreshing];
    
    

    
    
    
    [self.view addSubview:_tableView];
    
    self.listLoader = [[ListLoader alloc] init];

    __weak typeof(self) wself = self;

    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListModel *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
    [self get];
}

- (void)loadNewData {
//    NSLog(@"REFRESHED");
//    self.tableView.mj_footer.hidden = YES;
//    dispatch_after(DISPATCH_TIME_NOW, dispatch_main(), ^{
//
//    });
    [NSThread sleepForTimeInterval:1];
    [self.tableView.mj_footer endRefreshing];
    [self.tableView.mj_header endRefreshing];
}

#pragma mark - cell数量
//返回显示数量
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}

#pragma mark - cell布局
//返回cell设置
- (cell1*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    cell1 * cell=[tableView dequeueReusableCellWithIdentifier:@"id"];
    if(!cell){
        cell=[[cell1 alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"id"];
        //自定义的delegate
        cell.delegate=self;
    }
    [cell layoutTableViewCellWithItem:[_dataArray objectAtIndex:indexPath.row]];
    return cell;
}

#pragma mark - cell高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100;
}

#pragma mark - tableview的点击代理
//设置delegate点击事件——nav到下一个页面
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ListModel *item = [self.dataArray objectAtIndex:indexPath.row];
//    跳转到webview页面
    Webpage *controller = [[Webpage alloc]initWithUrlString:item.url];
    controller.title = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    [self.navigationController pushViewController:controller animated:YES];
}


//从cell1中得到的delegate——用于监听cell中的事件
#pragma mark - delete按钮事件
- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton {
//    //构造deletecell
//    GTDeleteCell *deleteview = [[GTDeleteCell alloc]initWithFrame:self.view.bounds];
//
//    //将deletebutton的坐标系转换到window的坐标系中
//    CGRect rect = [tableViewCell convertRect:deleteButton.frame toView:nil];
//
//    //防止循环引用
//    __weak typeof(self) wself = self;
//    
//    //调用showdeelteview函数
//    [deleteview showDeleteViewFromPoint:rect.origin clickBlock:^{
//        __strong typeof(wself)strongSelf = wself;
////        [strongSelf.dataArray removeLastObject];
//        [strongSelf.tableView deleteRowsAtIndexPaths:@[[strongSelf.tableView indexPathForCell:tableViewCell]] withRowAnimation:UITableViewRowAnimationAutomatic];
//    }];
}


-(void)get
{
    //1.创建会话管理者
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    //2.发送GET请求
    /*
     第一个参数:请求路径(不包含参数).NSString
     第二个参数:字典(发送给服务器的数据~参数)
     第三个参数:progress 进度回调
     第四个参数:success 成功回调
                task:请求任务
                responseObject:响应体信息(JSON--->OC对象)
     第五个参数:failure 失败回调
                error:错误信息
     响应头:task.response
     */
    [manager GET:@"https://m.10jqka.com.cn/todayhot.json" parameters:nil headers:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.dataArray = responseObject[@"pageItems"];
        NSLog(@"%@---%@",[responseObject class],responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"请求失败--%@",error);
    }];
    
//    [manager GET:@"http://test1.aihuawen.com//api/v1/S_001" parameters:paramDict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//
//        NSLog(@"%@---%@",[responseObject class],responseObject);
//
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSLog(@"请求失败--%@",error);
//    }];
}

@end




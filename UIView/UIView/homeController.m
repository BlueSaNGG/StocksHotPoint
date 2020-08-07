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

#pragma mark - 私有变量定义
@interface homeController ()<UITableViewDataSource,UITableViewDelegate, cell1Delegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, strong) NSArray *dataArray;
@property(nonatomic, strong) ListLoader *listLoader;
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
    [self.view addSubview:_tableView];
    
    self.listLoader = [[ListLoader alloc] init];
    
    __weak typeof(self) wself = self;
    
    [self.listLoader loadListDataWithFinishBlock:^(BOOL success, NSArray<ListModel *> * _Nonnull dataArray) {
        __strong typeof(wself) strongSelf = wself;
        strongSelf.dataArray = dataArray;
        [strongSelf.tableView reloadData];
    }];
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

@end




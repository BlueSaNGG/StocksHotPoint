//
//  settingViewController.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/7.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "settingViewController.h"
#import "settingTableViewCell.h"

@interface settingViewController () <UITableViewDelegate, UITableViewDataSource>
@property(nonatomic, copy) NSArray *optionsName;
@end

@implementation settingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置option的名称
    _optionsName = @[@"自动升级",@"意见反馈",@"关于"];
    
    // Do any additional setup after loading the view.
    self.title = @"设置";
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    UITableView *options = [[UITableView alloc] initWithFrame:CGRectMake(0, 24, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];

    
    
    //设置datasource和delegate
    options.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1.0];
    options.dataSource = self;
    options.delegate = self;
    options.separatorColor = [UIColor clearColor];
    
    
    
    [self.view addSubview:options];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    settingTableViewCell *cell = [[settingTableViewCell alloc] init];
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"设置-底"]];
    cell.textLabel.text = _optionsName[indexPath.section];
    cell.textLabel.font = [UIFont systemFontOfSize:32];
    cell.textLabel.textColor = [UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:1];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 36;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] init];
    headerView.backgroundColor = [UIColor clearColor];
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 88;
}



@end

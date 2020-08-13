//
//  AboutViewController.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/13.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //title设置
    self.navigationItem.title = @"关于";
    
    //icon设置
    UIImageView *iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ICON-1024-底.png"]];
    [iconView setFrame:CGRectMake(0, 40, 100, 100)];
    [iconView setCenter:CGPointMake(self.view.bounds.size.width/2, iconView.center.y)];
    [self.view addSubview:iconView];
    
    //标题设置
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, iconView.frame.origin.y+iconView.frame.size.height+14, 0, 0)];
    titleLabel.text = @"同花顺股市热点";
    titleLabel.font = [UIFont systemFontOfSize:20];
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor colorWithRed:22/255.0 green:22/255.0 blue:22/255.0 alpha:1];
    [titleLabel setCenter:CGPointMake(self.view.bounds.size.width/2, titleLabel.center.y)];
    [self.view addSubview:titleLabel];
    
    //版本号设置
    UILabel *versionLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleLabel.frame.origin.y+titleLabel.frame.size.height+12, 0, 0)];
    versionLabel.text = @"V1.00.1";
    versionLabel.font = [UIFont systemFontOfSize:17];
    [versionLabel sizeToFit];
    versionLabel.textColor = [UIColor colorWithRed:170/255.0 green:170/255.0 blue:170/255.0 alpha:1];
    [versionLabel setCenter:CGPointMake(self.view.bounds.size.width/2, versionLabel.center.y)];
    [self.view addSubview:versionLabel];
    
    //官方网站设置
    UIView *officialWebsite = [[UIView alloc] initWithFrame:CGRectMake(0, versionLabel.frame.origin.y+versionLabel.frame.size.height+24, 228, 44)];
    officialWebsite.backgroundColor =  [UIColor colorWithPatternImage:[UIImage imageNamed:@"分享-底.png"]];
    //加入文字
    UILabel *officialLabel = [[UILabel alloc] init];
    officialLabel.text = @"官方网站";
    officialLabel.font = [UIFont systemFontOfSize:15];
    [officialLabel sizeToFit];
    officialLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1];
    //加入icon
    UIImage *officialIcon = [UIImage imageNamed:@"关于-电脑客户端图标.png"];
    UIImageView *officialView = [[UIImageView alloc] initWithImage:officialIcon];
    [officialView sizeToFit];
    [officialView setCenter:CGPointMake(114-30, 22)];
    [officialLabel setCenter:CGPointMake(114+30, 22)];
    [officialWebsite setCenter:CGPointMake(self.view.bounds.size.width/2, officialWebsite.center.y)];

    [officialWebsite addSubview:officialView];
    [officialWebsite addSubview:officialLabel];
    [self.view addSubview:officialWebsite];
    
    
    //底部logo设置
    UIImage *bottomLogo = [UIImage imageNamed:@"关于-同花顺logo.png"];
    UIImageView *bottomView = [[UIImageView alloc] initWithImage:bottomLogo];
    [bottomView setFrame:CGRectMake(0, self.view.bounds.size.height-48-44-bottomLogo.size.height, 0, 0)];
    [bottomView sizeToFit];
    [bottomView setCenter:CGPointMake(self.view.bounds.size.width/2, bottomView.center.y)];
    [self.view addSubview:bottomView];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

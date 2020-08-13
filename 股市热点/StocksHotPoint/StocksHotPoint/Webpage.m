//
//  Webpage.m
//  UIView
//
//  Created by myhexin on 2020/7/31.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "Webpage.h"
#import <WebKit/WebKit.h>  //需要引入webkit
#import "wenStocks.h"
#import <UMCommon/MobClick.h>
#import <MBProgressHUD.h>

@interface Webpage ()<WKNavigationDelegate>
@property(nonatomic, strong ,readwrite) WKWebView *webView;
@property(nonatomic, strong ,readwrite) UIProgressView *progressView;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, strong) UIView *shareView;
@property(nonatomic, strong) UIView *shareBox;
@property(nonatomic, strong) UIView *shareBack;
@property(nonatomic, strong) wenStocks *wenGuPage;
@end

@implementation Webpage

//取消监听
//重载消亡函数
- (void)dealloc
{
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}


- (instancetype)initWithUrlString:(NSString *)urlString {
    self = [super init];
    if(self) {
        self.url = urlString;
        _wenGuPage = [[wenStocks alloc] init];
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //加入一个webview
    self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-192-24)];
        //对webview加入delegate控制
        self.webView.navigationDelegate = self;
        self.webView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
        self.webView;
    })];
    
    //并且加入progressview——进度条
    [self.view addSubview:({
        self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 20)];
        self.progressView.progressTintColor = [UIColor greenColor];
        self.progressView.trackTintColor = [UIColor redColor];
        self.progressView;
    })];
    
    
    

    //加入分享按钮
    [self.view addSubview:({

        self.shareView = [[UIView alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x, self.webView.bounds.size.height+84, self.view.bounds.size.width, 44)];
        self.shareView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"分享-底.png"]];
        //加入按钮和文字
        UILabel *share = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 44)];
        share.center = CGPointMake(self.shareView.bounds.size.width/2+30, self.shareView.bounds.size.height/2);
        share.font = [UIFont systemFontOfSize:15];
        share.text = @"分享";
        share.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
        [self.shareView addSubview:share];

        UIImageView *shareImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分享-图标"]];
        [shareImg setFrame:CGRectMake(0, 0, 20, 20)];
        shareImg.center = CGPointMake(self.shareView.bounds.size.width/2-30, self.shareView.bounds.size.height/2);
        [self.shareView addSubview:shareImg];
  
//// - 使用uibutton
        UIButton *ShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x, _shareView.frame.origin.y, self.view.bounds.size.width, 138)];
        ShareBtn.backgroundColor = [UIColor clearColor];
        ShareBtn.center = CGPointMake(self.shareView.bounds.size.width/2, self.shareView.bounds.size.height/4);
        [ShareBtn addTarget:self action:@selector(shareViewClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView addSubview:ShareBtn];

        self.shareView;
    })];
    
//加入手机炒股客户端下载
    //分割线
    UIImageView *downloadLine = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"资讯详情-分割线.png"]];
    [downloadLine setFrame:CGRectMake(10, 0, self.view.bounds.size.width-20, 2)];
    //总view
    UIView *downloadView = [[UIView alloc] initWithFrame:CGRectMake(0, self.shareView.frame.origin.y-84, self.view.bounds.size.width, 84)];
    downloadView.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    //下载框
    UIView *downLoadBtnView = [[UIButton alloc] initWithFrame:CGRectMake(0, 20, 290, 44)];
    [downLoadBtnView setCenter:CGPointMake(downloadView.center.x, downLoadBtnView.center.y)];
    downLoadBtnView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"运营-底.png"] ];
        //框内加入图片+label
    UIImageView *dlIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"运营-同花顺logo.png"]];
    [dlIcon setFrame:CGRectMake(0, 0, 30, 30)];
    [dlIcon setCenter:CGPointMake(50, downLoadBtnView.center.y/2)];
    //添加文字
    UILabel *dlLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 160, 40)];
    [dlLabel setCenter:CGPointMake(160, downLoadBtnView.center.y/2)];
//    dlLabel.backgroundColor = [UIColor redColor];
    dlLabel.text = @"手机炒股客户端下载";
    dlLabel.font = [UIFont systemFontOfSize:15];
    dlLabel.textColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:1.0];
    //添加箭头
    UIImageView *dlArrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"运营-箭头.png"]];
    [dlArrow setFrame:CGRectMake(0, 0, 20, 20)];
    [dlArrow setCenter:CGPointMake(250, downLoadBtnView.center.y/2)];
    
    [downLoadBtnView addSubview:dlArrow];
    [downLoadBtnView addSubview:dlLabel];
    [downLoadBtnView addSubview:dlIcon];
    [downloadView addSubview:downLoadBtnView];
    [downloadView addSubview:downloadLine];
    [self.view addSubview:downloadView];
    
    //加入网页跳转事件
    UITapGestureRecognizer *dlClicked = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(downloadClicked)];
    [downloadView addGestureRecognizer:dlClicked];
    

//弹框的uiview
    _shareBox = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 247.5)];
    _shareBox.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"分享-弹出框-底.png"]];
    //弹框的文字
    UILabel *shareBoxLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 26, 60, 40)];
    [shareBoxLabel setCenter:CGPointMake(_shareBox.center.x, shareBoxLabel.center.y)];
    shareBoxLabel.text = @"分享到";
    shareBoxLabel.font = [UIFont systemFontOfSize:18];
    shareBoxLabel.textColor = [UIColor colorWithRed:28/255.0 green:28/255.0 blue:28/255.0 alpha:1];
    [_shareBox addSubview:shareBoxLabel];
    //弹框的图标
    //朋友圈
    UIButton *pyqBtn = [[UIButton alloc] initWithFrame:CGRectMake(25, 80, 60, 60)];
    [pyqBtn setImage:[UIImage imageNamed:@"朋友圈.png"] forState:UIControlStateNormal];
    [pyqBtn addTarget:self action:@selector(pyqClicked) forControlEvents:UIControlEventTouchUpInside];
    [_shareBox addSubview:pyqBtn];
    
    UILabel *pyqLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 145, 100, 60)];
    pyqLabel.font = [UIFont systemFontOfSize:12];
    pyqLabel.text = @"微信朋友圈";
    [pyqLabel sizeToFit];
    pyqLabel.textColor = [UIColor blackColor];
    [_shareBox addSubview:pyqLabel];
    //微信好友
    UIButton *wxhyBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 60, 60)];
    [wxhyBtn setCenter:CGPointMake((_shareBox.bounds.size.width-50-60)/3.0+25+30, wxhyBtn.center.y)];
    [wxhyBtn setImage:[UIImage imageNamed:@"微信好友.png"] forState:UIControlStateNormal];
    [wxhyBtn addTarget:self action:@selector(wxhyClicked) forControlEvents:UIControlEventTouchUpInside];
    [_shareBox addSubview:wxhyBtn];
    
    UILabel *wxhyLabel = [[UILabel alloc] initWithFrame:CGRectMake(125, 145, 100, 60)];
    wxhyLabel.font = [UIFont systemFontOfSize:12];
    wxhyLabel.text = @"微信好友";
    [wxhyLabel sizeToFit];
    [wxhyLabel setCenter:CGPointMake((_shareBox.bounds.size.width-50-60)/3.0+25+30, wxhyLabel.center.y)];
    wxhyLabel.textColor = [UIColor blackColor];
    [_shareBox addSubview:wxhyLabel];
    //新浪微博
    UIButton *xlwbBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 80, 60, 60)];
    [xlwbBtn setCenter:CGPointMake((_shareBox.bounds.size.width-50-60)*2/3.0+25+30, xlwbBtn.center.y)];
    [xlwbBtn setImage:[UIImage imageNamed:@"新浪微博.png"] forState:UIControlStateNormal];
    [xlwbBtn addTarget:self action:@selector(xlwbClicked) forControlEvents:UIControlEventTouchUpInside];
    [_shareBox addSubview:xlwbBtn];
    
    UILabel *xlwbLabel = [[UILabel alloc] initWithFrame:CGRectMake(225, 145, 100, 60)];
    xlwbLabel.font = [UIFont systemFontOfSize:12];
    xlwbLabel.text = @"新浪微博";
    [xlwbLabel sizeToFit];
    [xlwbLabel setCenter:CGPointMake((_shareBox.bounds.size.width-50-60)*2/3.0+25+30, xlwbLabel.center.y)];
    xlwbLabel.textColor = [UIColor blackColor];
    [_shareBox addSubview:xlwbLabel];
    //腾讯微博
    UIButton *txwbBtn = [[UIButton alloc] initWithFrame:CGRectMake(_shareBox.bounds.size.width-25-60, 80, 60, 60)];
    [txwbBtn setImage:[UIImage imageNamed:@"腾讯微博.png"] forState:UIControlStateNormal];
    [txwbBtn addTarget:self action:@selector(txwbClicked) forControlEvents:UIControlEventTouchUpInside];
    [_shareBox addSubview:txwbBtn];
    
    UILabel *txwbLabel = [[UILabel alloc] initWithFrame:CGRectMake(325, 145, 100, 60)];
    txwbLabel.font = [UIFont systemFontOfSize:12];
    txwbLabel.text = @"腾讯微博";
    [txwbLabel sizeToFit];
    [txwbLabel setCenter:CGPointMake(txwbBtn.center.x, txwbLabel.center.y)];    txwbLabel.textColor = [UIColor blackColor];
    [_shareBox addSubview:txwbLabel];
    
    //取消按钮
    UIView *cancelLine = [[UIView alloc] initWithFrame:CGRectMake(40, _shareBox.bounds.size.height-44, _shareBox.bounds.size.width-80, 1)];
    cancelLine.backgroundColor = [UIColor colorWithRed:77/255.0 green:134/255.0 blue:198/255.0 alpha:1.0];
    //加入按钮和文字
    UIButton *cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, _shareBox.bounds.size.height-44, _shareBox.bounds.size.width, 44)];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    cancelBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cancelBtn addTarget:self action:@selector(cancelClicked) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitleColor:[UIColor colorWithRed:77/255.0 green:134/255.0 blue:198/255.0 alpha:1.0] forState:UIControlStateNormal];
    [_shareBox addSubview:cancelLine];
    [_shareBox addSubview:cancelBtn];

//分享后的暗化背景
    _shareBack = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _shareBack.backgroundColor = [UIColor colorWithRed:20/255.0 green:20/255.0 blue:20/255.0 alpha:0.5];
    //点击消失
    UITapGestureRecognizer *clickBack = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backClicked)];
    [_shareBack addGestureRecognizer:clickBack];
    [self.view addSubview:_shareBack];
    //初始化隐藏背景
    [_shareBack setHidden:YES];
    


    [self.view addSubview:_shareBox];


    //执行网络请求
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
    
    //对webview进行kvo监听
    [self.webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    

}
//delegate——确定跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    decisionHandler(WKNavigationActionPolicyAllow);
}
//delegate完成加载
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation{
    [self.progressView removeFromSuperview];
}


//kvo收听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //并且改变progressview的值
    self.progressView.progress = self.webView.estimatedProgress;
}

#pragma mark - share点击事件
- (void)shareViewClicked {
    //埋点
    [MobClick event:@"share"];
    //显示背景
    [_shareBack setHidden:NO];
    //点击后显示分享按钮
    [UIView animateWithDuration:0.3 animations:^{
        [self.shareBox setFrame:CGRectMake(0, self.view.bounds.size.height-247.5, self.view.bounds.size.width, 247.5)];
    }];
}

#pragma mark - cancel点击事件
- (void)cancelClicked {
    [UIView animateWithDuration:0.3 animations:^{
        [self.shareBox setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 0)];
    }];
    [_shareBack setHidden:YES];
}

#pragma mark - 点击背景=cancel
- (void)backClicked {
    [self cancelClicked];
}

#pragma mark - 进入问股页面
- (void)wenStockClicked {
    [self.navigationController pushViewController:_wenGuPage animated:YES];
}

#pragma mark - 进入下载页面
- (void)downloadClicked {

}

#pragma mark - 点击分享
- (void)pyqClicked {
    //点击埋点
    [MobClick event:@"share" attributes:@{@"share":@"pyq"}];
    //返回
    [self cancelClicked];
    [self showProgress];
}

- (void)wxhyClicked {
    //点击埋点
    [MobClick event:@"share" attributes:@{@"share":@"wxhy"}];
    //返回
    [self cancelClicked];
    [self showProgress];
}

- (void)xlwbClicked {
    //点击埋点
    [MobClick event:@"share" attributes:@{@"share":@"xlwb"}];
    //返回
    [self cancelClicked];
    [self showProgress];
}

- (void)txwbClicked {
    //点击埋点
    [MobClick event:@"share" attributes:@{@"share":@"txwb"}];
    //返回
    [self cancelClicked];
    [self showProgress];
}



#pragma mark - 设置MBProgressHUD
- (void)showProgress {
    //加载框
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud.label setText:@"正在分享..."];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        [NSThread sleepForTimeInterval:1];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            //初始化错误提示
            UILabel *failAlert = [[UILabel alloc]init];
            failAlert.font = [UIFont systemFontOfSize:36];
            failAlert.backgroundColor = [UIColor grayColor];
            failAlert.textColor = [UIColor whiteColor];
            [failAlert setText:@"分享成功"];
            [failAlert sizeToFit];
            [failAlert setCenter:CGPointMake(self.view.center.x, self.view.center.y-50)];
            [self.view addSubview:failAlert];
            [UIView animateWithDuration:2 animations:^{
                failAlert.alpha=0;
            } completion:^(BOOL finished) {
                [failAlert removeFromSuperview];
            }];
        });
    });
}

@end

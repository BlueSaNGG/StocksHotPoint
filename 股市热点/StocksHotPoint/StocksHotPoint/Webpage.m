//
//  Webpage.m
//  UIView
//
//  Created by myhexin on 2020/7/31.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "Webpage.h"
#import <WebKit/WebKit.h>  //需要引入webkit

@interface Webpage ()<WKNavigationDelegate>
@property(nonatomic, strong ,readwrite) WKWebView *webView;
@property(nonatomic, strong ,readwrite) UIProgressView *progressView;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, strong) UIView *shareView;
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
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //问股按钮
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"问股" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.rightBarButtonItem = rightBtn;
    [self.navigationItem.rightBarButtonItem setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:28],NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];

    
    
    
    //加入一个webview
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-138)];
        //对webview加入delegate控制
        self.webView.navigationDelegate = self;

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
        self.shareView = [[UIView alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.size.height+self.webView.frame.origin.y, self.view.bounds.size.width, 138)];
        self.shareView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"分享-底.png"]];
        //加入按钮和文字
        UILabel *share = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 50)];
        share.center = CGPointMake(self.shareView.bounds.size.width/2+40, self.shareView.bounds.size.height/4);
        share.font = [UIFont systemFontOfSize:30];
        share.text = @"分享";
        share.textColor = [UIColor colorWithRed:128/255.0 green:128/255.0 blue:128/255.0 alpha:1];
        [self.shareView addSubview:share];

        UIImageView *shareImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"分享-图标"]];
        [shareImg setFrame:CGRectMake(0, 0, 40, 40)];
        shareImg.center = CGPointMake(self.shareView.bounds.size.width/2-40, self.shareView.bounds.size.height/4);
        [self.shareView addSubview:shareImg];
  
//// - 使用uibutton
        UIButton *ShareBtn = [[UIButton alloc] initWithFrame:CGRectMake(self.webView.frame.origin.x, self.webView.frame.size.height+self.webView.frame.origin.y, self.view.bounds.size.width, 138)];
        ShareBtn.backgroundColor = [UIColor clearColor];
        ShareBtn.center = CGPointMake(self.shareView.bounds.size.width/2, self.shareView.bounds.size.height/4);
        [ShareBtn addTarget:self action:@selector(shareViewClicked) forControlEvents:UIControlEventTouchUpInside];
        [self.shareView addSubview:ShareBtn];

        
        self.shareView;
    })];
    
    
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
    //点击后显示分享按钮

    NSLog(@"clicked");
}

@end

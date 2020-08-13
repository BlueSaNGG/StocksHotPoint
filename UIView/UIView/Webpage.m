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
        self.url = @"https://www.baidu.com";
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //加入一个webview
    [self.view addSubview:({
        self.webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, self.view.frame.size.height-88)];
        //对webview加入delegate控制
        self.webView.navigationDelegate=self;
        self.webView;
    })];
    
    //并且加入progressview——进度条
    [self.view addSubview:({
        self.progressView=[[UIProgressView alloc] initWithFrame:CGRectMake(0, 88, self.view.frame.size.width, 20)];
        self.progressView.progressTintColor=[UIColor greenColor];
        self.progressView.trackTintColor=[UIColor redColor];
        self.progressView;
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
    NSLog(@"");
}


//kvo收听
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    //并且改变progressview的值
    self.progressView.progress = self.webView.estimatedProgress;
    NSLog(@"");
}

@end

//
//  wenStocks.m
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/10.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "wenStocks.h"
#import "wenStocksCell.h"
#import <AFNetworking.h>





@interface wenStocks () <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, NSXMLParserDelegate>
@property(nonatomic, strong) UITableView *tableView;
@property(nonatomic, copy) NSMutableArray *messageArray;
@property(nonatomic, strong) UIView *toolBar;
@property(nonatomic, strong) UITextField *textField;
@property(nonatomic, strong) UIButton *passBtn;
@property(nonatomic, assign) BOOL findDescription;
@property(nonatomic, copy) NSString *Description;
- (void)keyRiseUp:(NSNotification *)noti;
@end

@implementation wenStocks
- (instancetype)init
{
    self = [super init];
    if (self) {
        _messageArray = [[NSMutableArray alloc] init];
        //创建cell
        wenStocksCell *cell = [[wenStocksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wenStocksCell" andMessageType:ChatMessageTo];
        //cell加入str
        [cell setStrLeft:@"你好！股票方面有什么需要帮忙的吗?"];
        //列表中存入cell
        [_messageArray addObject:cell];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //全部背景
        self.view.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    

    // - 导航栏设置
    //title设置
        self.navigationItem.title = @"问股";

    //导航栏背景设置
        //设置背景图片——现实backgroundcolor
        [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"标题栏.png"] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    //设置tableview
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height-112-24)];
    _tableView.separatorColor = [UIColor clearColor];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    
    //设置tableview点击收起聊天框
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBackground)];
    [_tableView addGestureRecognizer:tap];
    //设置cell复用
    [_tableView registerClass:[wenStocksCell class] forCellReuseIdentifier:@"wenStocksCell"];
    //加入tableview
    [self.view addSubview:_tableView];
    
    
    //底部工具栏
    _toolBar = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-112-24, self.view.bounds.size.width, 44)];
    _toolBar.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"分享-底.png"]];
    //加入聊天框
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(9, 9, 315, 30)];
    _textField.backgroundColor = [UIColor whiteColor];
    _textField.textColor = [UIColor blackColor];
    _textField.delegate = self;
    _textField.font = [UIFont systemFontOfSize:14];
    _textField.layer.cornerRadius = 10;
    [_textField setPlaceholder:@"请输入股票代码或一句话"];

    
    //加入button
    _passBtn = [[UIButton alloc] initWithFrame:CGRectMake(_textField.bounds.size.width+_textField.bounds.origin.x+18, _textField.bounds.origin.y, 48, 29)];
    [_passBtn setCenter:CGPointMake(_passBtn.center.x, _textField.center.y)];
    [_passBtn setBackgroundImage:[UIImage imageNamed:@"问股-发送按钮.png"] forState:UIControlStateNormal];
    [_passBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_passBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_passBtn addTarget:self action:@selector(passClicked) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    //监视键盘的升起
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyRiseUp:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //将底部加入view
    [_toolBar addSubview:_passBtn];
    [_toolBar addSubview:_textField];
    [self.view addSubview:_toolBar];
    
}


#pragma mark - datasource & delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_messageArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    wenStocksCell *cell = _messageArray[indexPath.row];
    return cell;
}

#pragma mark - 设置键盘监听
- (void)keyRiseUp:(NSNotification *)noti {
    //取到动画事件
    CGFloat duration = [[noti.userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect keyboardFrame = [[noti.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    //判读是弹起还是收起
    if(keyboardFrame.origin.y >= self.view.bounds.size.height) {
        //收起
        [UIView animateWithDuration:duration animations:^{
            //toolbar下降
            [self.toolBar setFrame:CGRectMake(0, self.view.bounds.size.height-44, self.view.bounds.size.width, 44)];
            [self.tableView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.toolBar.frame.origin.y)];
            
        }];
    } else {
        //toolbar上升
//        [self.toolBar setFrame:CGRectMake(0, self.view.bounds.size.height, self.view.bounds.size.width, 44)];
        [UIView animateWithDuration:duration animations:^{
            //toolbar上升
            [self.toolBar setFrame:CGRectMake(0, self.view.bounds.size.height-keyboardFrame.size.height-44, self.view.bounds.size.width, 44)];
            //tableview上升
            [self.tableView setFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.toolBar.frame.origin.y)];
            [self scrollsToBottom];
        }];
    }
    
}

#pragma mark - 移除监听
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 收起键盘
- (void)tapBackground {
    [_textField resignFirstResponder];
}

#pragma mark - return代理
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self passClicked];
    return YES;
}

#pragma mark - 点击发送
- (void)passClicked {
    if([_textField.text length]>0) {
    //创建cell
    wenStocksCell *cell = [[wenStocksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wenStocksCell" andMessageType:ChatMessageFrom];
    //cell加入str
    [cell setStrRight:_textField.text];
    //列表中存入cell
    [_messageArray addObject:cell];
    [self.tableView reloadData];
    //滚动到底部
    [self scrollsToBottom];
    //网络请求
    [self pushText];
        
    //清空输入框
    [_textField setText:@""];
    }
    //收起键盘
    [self tapBackground];
}


#pragma mark - push请求
- (void)pushText {
    NSString *params = [NSString stringWithFormat:@"<xml>\
<ToUserName>13350</ToUserName>\
<FromUserName>123456</FromUserName>\
<CreateTime>1348831860</CreateTime>\
<MsgType>text</MsgType>\
<Content>%@</Content>\
<MsgId>test</MsgId>\
</xml>",_textField.text];
    AFHTTPSessionManager *managerPost = [AFHTTPSessionManager manager];
    managerPost.responseSerializer = [AFHTTPResponseSerializer serializer];
    //建立request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://comment.10jqka.com.cn/api/weixin.php"]];
    NSData *httpBody = [params dataUsingEncoding:NSUTF8StringEncoding];
    [request setHTTPBody:httpBody];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/xml" forHTTPHeaderField:@"Content-Type"];
    //进行请求
    [[managerPost dataTaskWithRequest:request uploadProgress:nil downloadProgress:nil completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if(error) {
            wenStocksCell *cell = [[wenStocksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wenStocksCell" andMessageType:ChatMessageTo];
            [cell setStrLeft:@"不给力，数据请求失败"];
            [self.messageArray addObject:cell];
            [self.tableView reloadData];
        }else {
        //xml解析
        NSXMLParser *xmlparser = [[NSXMLParser alloc] initWithData:responseObject];
        xmlparser.delegate = self;
        [xmlparser parse];
        }
        
    }]resume];
}




//当扫描到元素的开始时调用（attributeDict存放着元素的属性）
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    _findDescription = NO;
    if([elementName isEqualToString:@"Description"] || [elementName isEqualToString:@"Content"]) {
        _findDescription = YES;
    }
}

//得到其中的cdata内容
- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    if(_findDescription) {
    NSString *responseStr = [[NSString alloc] initWithData:CDATABlock encoding:NSUTF8StringEncoding];
    _Description = responseStr;
    //作为cell加入array中
    wenStocksCell *cell = [[wenStocksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"wenStocksCell" andMessageType:ChatMessageTo];
    //cell加入str
    [cell setStrLeft:_Description];
    //列表中存入cell
    [_messageArray addObject:cell];
    [_tableView reloadData];
    //滚动到底部
    [self scrollsToBottom];
    }
    _findDescription = NO;
}

- (void)scrollsToBottom {
    [_tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:_messageArray.count-1 inSection:0]  atScrollPosition:UITableViewScrollPositionBottom animated:YES];//这里一定要设置为NO，动画可能会影响到scrollerView，导致增加数据源之后，tableView到处乱跳

}


@end

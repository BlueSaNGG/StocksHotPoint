//
//  ListLoader.m
//  UIView
//
//  Created by myhexin on 2020/8/4.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "ListLoader.h"
#import "ListModel.h"
#import <AFNetworking.h>

@implementation ListLoader
/*
 1.string包装为NSURL
 2.NSURL包装为NSURLRequest
 3.request转为session
 4.session设置task
 5.taskresume执行task
 */


- (void)loadListDataWithFinishBlock:(listLoaderFinishBlock)finishBlock{
    NSString *urlString = @"https://m.10jqka.com.cn/todayhot.json";
    NSURL *listUrl = [NSURL URLWithString:urlString];
//    NSURLRequest *listRequest = [NSURLRequest requestWithURL:listUrl];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:listUrl completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSError *jsonError;
        //将data中二进制流转位json格式
        id jsonObj = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
        NSArray *dataArray = [(NSDictionary *)jsonObj objectForKey:@"pageItems"];
        NSMutableArray *listItemArray = @[].mutableCopy;
        for(NSDictionary *info in dataArray) {
            //数据module化
            ListModel *listItem = [[ListModel alloc] init];
            [listItem configWithDictionary:info];
            [listItemArray addObject:listItem];
            NSLog(@"");
        }
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            if(finishBlock) {
                finishBlock(error==nil, listItemArray.copy);
            }
        });
    }];
    [dataTask resume];
    
    
    //AFNETWORING

    

}

@end

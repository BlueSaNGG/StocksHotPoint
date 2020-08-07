//
//  ListModel.m
//  UIView
//
//  Created by myhexin on 2020/8/4.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import "ListModel.h"

@implementation ListModel

- (void)configWithDictionary:(NSDictionary *)dictionary {
    _ctime = [dictionary objectForKey:@"ctime"];
    _hot = [dictionary objectForKey:@"hot"];
    _pic = [dictionary objectForKey:@"pic"];
    _seq = [dictionary objectForKey:@"seq"];
    _summary = [dictionary objectForKey:@"summary"];
    _title = [dictionary objectForKey:@"title"];
    _url = [dictionary objectForKey:@"url"];
    _stocks = [dictionary objectForKey:@"stocks"];
}

@end

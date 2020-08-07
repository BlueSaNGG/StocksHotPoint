//
//  ListModel.h
//  UIView
//
//  Created by myhexin on 2020/8/4.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ListModel : NSObject

@property(nonatomic, copy) NSString *ctime;
@property(nonatomic, copy) NSNumber *hot;
@property(nonatomic, copy) NSString *pic;
@property(nonatomic, copy) NSString *seq;
@property(nonatomic, copy) NSString *summary;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *url;
@property(nonatomic, copy) NSString *stocks;

- (void)configWithDictionary:(NSDictionary *)dictionary;

@end

NS_ASSUME_NONNULL_END

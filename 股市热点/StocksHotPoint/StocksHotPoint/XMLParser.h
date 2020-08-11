//
//  XMLParser.h
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/11.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XMLParser : NSObject
@property(nonatomic, copy) NSString *XML;
@property(nonatomic, copy) NSString *Description;
@property(nonatomic, copy) NSString *Content;
- (void)findDescription;
@end

NS_ASSUME_NONNULL_END

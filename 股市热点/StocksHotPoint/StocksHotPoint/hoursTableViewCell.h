//
//  hoursTableViewCell.h
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/6.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ListModel;
NS_ASSUME_NONNULL_BEGIN

@interface hoursTableViewCell : UITableViewCell
- (instancetype)initWithData:(ListModel *)ListModel;
@end

NS_ASSUME_NONNULL_END

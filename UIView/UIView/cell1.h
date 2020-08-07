//
//  cell1.h
//  UIView
//
//  Created by myhexin on 2020/7/30.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;

NS_ASSUME_NONNULL_BEGIN

/*
 点击删除按钮
 */
//自定义delegate，在viewcontroller中访问此button
@protocol cell1Delegate <NSObject>

- (void)tableViewCell:(UITableViewCell *)tableViewCell clickDeleteButton:(UIButton *)deleteButton;

@end
/*
 新闻列表cell
 */

@interface cell1 : UITableViewCell
@property(nonatomic, weak) id<cell1Delegate> delegate;

- (void) layoutTableViewCellWithItem:(ListModel *)item;
@end

NS_ASSUME_NONNULL_END

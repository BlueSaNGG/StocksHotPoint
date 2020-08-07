//
//  GTDeleteCell.h
//  UIView
//
//  Created by myhexin on 2020/8/3.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface GTDeleteCell : UIView
- (void)showDeleteViewFromPoint:(CGPoint)point clickBlock:(dispatch_block_t)clickBlock;
@end

NS_ASSUME_NONNULL_END

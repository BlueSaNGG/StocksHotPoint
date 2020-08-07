//
//  ListLoader.h
//  UIView
//
//  Created by myhexin on 2020/8/4.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ListModel;

typedef void(^listLoaderFinishBlock) (BOOL success, NSArray<ListModel *> * _Nonnull dataArray);
    

NS_ASSUME_NONNULL_BEGIN
/*
    列表请求——热点掘金
*/


@interface ListLoader : NSObject

- (void)loadListDataWithFinishBlock:(listLoaderFinishBlock)finishBlock;

@end

NS_ASSUME_NONNULL_END

//
//  wenStocksCell.h
//  StocksHotPoint
//
//  Created by myhexin on 2020/8/10.
//  Copyright © 2020 jinqi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


//枚举类型
typedef enum {
    ChatMessageFrom = 0,//来自对方的消息
    ChatMessageTo       //发给对方的消息
}ChatMesageType;

@interface wenStocksCell : UITableViewCell
@property (nonatomic, copy)NSString *str;
@property (nonatomic,assign)ChatMesageType messageType;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andMessageType:(ChatMesageType)messagetype;
- (void)setStrLeft:(NSString *)str;
- (void)setStrRight:(NSString *)str;
@end

NS_ASSUME_NONNULL_END

//
//  PickView.h
//  CustomePickView
//
//  Created by MJHee on 2017/4/19.
//  Copyright © 2017年 MJBaby. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^sureSelectBlock)(NSString *);

@interface PickView : UIView

@property (nonatomic, strong) sureSelectBlock sureselectBlock;

@property (nonatomic, strong) dispatch_block_t cancelselectBlock;
//每列需要显示的数据
@property(nonatomic,strong)NSMutableArray *yearArray;

- (void)show;

@end

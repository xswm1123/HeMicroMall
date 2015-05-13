//
//  UIControl+LKSignal.h
//  LK_EasySignal
//
//  Created by hesh on 13-9-4.
//  Copyright (c) 2013年 ilikeido. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void (^LKActionBlock)(id weakSender);

@interface UIControl (LK_EasySignal_Private)

- (void)handleControlEvents:(UIControlEvents)controlEvents withBlock:(LKActionBlock)actionBlock;

- (void)removeActionBlocksForControlEvents:(UIControlEvents)controlEvents;

@end


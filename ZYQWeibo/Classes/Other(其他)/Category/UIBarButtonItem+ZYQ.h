//
//  UIBarButtonItem+ZYQ.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-2.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ZYQ)
/**
 *   快速创建一个显示图片的item
 *  @param action   监听方法
 *
 */
+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action;
@end

//
//  UIBarButtonItem+ZYQ.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-2.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "UIBarButtonItem+ZYQ.h"

@implementation UIBarButtonItem (ZYQ)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon highIcon:(NSString *)highIcon target:(id)target action:(SEL)action{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageWithName:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageWithName:highIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc] initWithCustomView:button];
}
@end

//
//  ZYQTabBar.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-2.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYQTabBar;
//定义ZYQTabBarDelegate和相关方法
@protocol ZYQTabBarDelegate <NSObject>

@optional
- (void)tabBar:(ZYQTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to;

@end


@interface ZYQTabBar : UIView
- (void)addTabBarButtonWithItem:(UITabBarItem *)item;

@property (nonatomic, weak) id<ZYQTabBarDelegate> delegate;
@end

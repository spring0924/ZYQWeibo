//
//  ZYQTabBarViewController.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-1.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQTabBarViewController.h"
#import "ZYQHomeViewController.h"
#import "ZYQMessageViewController.h"
#import "ZYQMeViewController.h"
#import "ZYQDiscoverViewController.h"
#import "ZYQNavigationController.h"
#import "UIImage+ZYQ.h"
#import "ZYQTabBar.h"
#import "ZYQUserTool.h"
#import "ZYQAccountTool.h"
#import "ZYQAccount.h"
#import "ZYQComposeViewController.h"
@interface ZYQTabBarViewController () <ZYQTabBarDelegate>
/**
 *  自定义的tabbar
 */
@property (nonatomic, weak) ZYQTabBar *customTabBar;
@property (nonatomic, strong) ZYQHomeViewController *home;
@property (nonatomic, strong) ZYQMessageViewController *message;
// 3.广场
@property (nonatomic, strong) ZYQDiscoverViewController *discover;
// 4.我
@property (nonatomic, strong) ZYQMeViewController *me;
@end
@implementation ZYQTabBarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 初始化tabbar
    [self setupTabbar];
    
    // 初始化所有的子控制器
    [self setupAllChildViewControllers];
    
    // 定时检查未读数
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(checkUnreadCount) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

/**
 *  定时检查未读数
 */
- (void)checkUnreadCount
{
    //    ZYQLog(@"checkUnreadCount-----");
    
    // 1.请求参数
    ZYQUserUnreadCountParam *param = [ZYQUserUnreadCountParam param];
    param.uid = @([ZYQAccountTool account].uid);
    
    // 2.发送请求
    [ZYQUserTool userUnreadCountWithParam:param success:^(ZYQUserUnreadCountResult *result) {
        // 3.设置badgeValue
        // 3.1.首页
        self.home.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.status];
        
        // 3.2.消息
        self.message.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.messageCount];
        
        // 3.3.我
        self.me.tabBarItem.badgeValue = [NSString stringWithFormat:@"%d", result.follower];
        
        // 4.设置图标右上角的数字
        [UIApplication sharedApplication].applicationIconBadgeNumber = result.count;
    } failure:^(NSError *error) {
        
    }];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 删除系统自动生成的UITabBarButton
    for (UIView *child in self.tabBar.subviews) {
        if ([child isKindOfClass:[UIControl class]]) {
            [child removeFromSuperview];
        }
    }
}

/**
 *  初始化tabbar
 */
- (void)setupTabbar
{
    ZYQTabBar *customTabBar = [[ZYQTabBar alloc] init];
    customTabBar.frame = self.tabBar.bounds;
    customTabBar.delegate = self;
    [self.tabBar addSubview:customTabBar];
    self.customTabBar = customTabBar;
}

#pragma mark - tabbar的代理方法
/**
 *  监听tabbar按钮的改变
 *  @param from   原来选中的位置
 *  @param to     最新选中的位置
 */
- (void)tabBar:(ZYQTabBar *)tabBar didSelectedButtonFrom:(int)from to:(int)to
{
    self.selectedIndex = to;
    
    if (to == 0) { // 点击了首页
        [self.home refresh];
    }
}

/**
 *  监听加号按钮点击
 */
- (void)tabBarDidClickedPlusButton:(ZYQTabBar *)tabBar
{
    ZYQComposeViewController *compose = [[ZYQComposeViewController alloc] init];
    ZYQNavigationController *nav = [[ZYQNavigationController alloc] initWithRootViewController:compose];
    [self presentViewController:nav animated:YES completion:nil];
}

/**
 *  初始化所有的子控制器
 */
- (void)setupAllChildViewControllers
{
    // 1.首页
    ZYQHomeViewController *home = [[ZYQHomeViewController alloc] init];
    [self setupChildViewController:home title:@"首页" imageName:@"tabbar_home" selectedImageName:@"tabbar_home_selected"];
    self.home = home;
    
    // 2.消息
    ZYQMessageViewController *message = [[ZYQMessageViewController alloc] init];
    [self setupChildViewController:message title:@"消息" imageName:@"tabbar_message_center" selectedImageName:@"tabbar_message_center_selected"];
    self.message = message;
    
    // 3.广场
    ZYQDiscoverViewController *discover = [[ZYQDiscoverViewController alloc] init];
    [self setupChildViewController:discover title:@"广场" imageName:@"tabbar_discover" selectedImageName:@"tabbar_discover_selected"];
    self.discover = discover;
    
    // 4.我
    ZYQMeViewController *me = [[ZYQMeViewController alloc] init];
    [self setupChildViewController:me title:@"我" imageName:@"tabbar_profile" selectedImageName:@"tabbar_profile_selected"];
    self.me = me;
}

/**
 *  初始化一个子控制器
 *
 *  @param childVc           需要初始化的子控制器
 *  @param title             标题
 *  @param imageName         图标
 *  @param selectedImageName 选中的图标
 */
- (void)setupChildViewController:(UIViewController *)childVc title:(NSString *)title imageName:(NSString *)imageName selectedImageName:(NSString *)selectedImageName
{
    // 1.设置控制器的属性
    childVc.title = title;
    // 设置图标
    childVc.tabBarItem.image = [UIImage imageWithName:imageName];
    // 设置选中的图标
    UIImage *selectedImage = [UIImage imageWithName:selectedImageName];
    if (iOS7) {
        childVc.tabBarItem.selectedImage = [selectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    } else {
        childVc.tabBarItem.selectedImage = selectedImage;
    }
    
    // 2.包装一个导航控制器
    ZYQNavigationController *nav = [[ZYQNavigationController alloc] initWithRootViewController:childVc];
    [self addChildViewController:nav];
    
    // 3.添加tabbar内部的按钮
    [self.customTabBar addTabBarButtonWithItem:childVc.tabBarItem];
}

@end

//
//  ZYQCommon.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-3.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#ifndef ZYQWeibo_ZYQCommon_h
#define ZYQWeibo_ZYQCommon_h
// 0.账号相关
#define ZYQAppKey @"2719864749"
#define ZYQAppSecret @"f1d6e0b57ca915f3b74430bbfa57e0d6"
#define ZYQRedirectURI @"http://www.baidu.com"
#define ZYQLoginURL [NSString stringWithFormat:@"https://api.weibo.com/oauth2/authorize?client_id=%@&redirect_uri=%@", ZYQAppKey, ZYQRedirectURI]

// 1.判断是否为iOS7
#define iOS7 ([[UIDevice currentDevice].systemVersion doubleValue] >= 7.0)

// 2.获得RGB颜色
#define ZYQColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 3.自定义Log
#ifdef DEBUG
#define ZYQLog(...) NSLog(__VA_ARGS__)
#else
#define ZYQLog(...)
#endif

// 4.是否为4inch
#define fourInch ([UIScreen mainScreen].bounds.size.height == 568)

// 5.微博cell上面的属性
/** 昵称的字体 */
#define ZYQStatusNameFont [UIFont systemFontOfSize:15]
/** 被转发微博作者昵称的字体 */
#define ZYQRetweetStatusNameFont ZYQStatusNameFont

/** 时间的字体 */
#define ZYQStatusTimeFont [UIFont systemFontOfSize:12]
/** 来源的字体 */
#define ZYQStatusSourceFont ZYQStatusTimeFont

/** 正文的字体 */
#define ZYQStatusContentFont [UIFont systemFontOfSize:13]
/** 被转发微博正文的字体 */
#define ZYQRetweetStatusContentFont ZYQStatusContentFont

/** 表格的边框宽度 */
#define ZYQStatusTableBorder 5

/** cell的边框宽度 */
#define ZYQStatusCellBorder 10

// 6.微博cell内部相册
#define ZYQPhotoW 70
#define ZYQPhotoH 70
#define ZYQPhotoMargin 10
// 7.常用的对象
#define ZYQNotificationCenter [NSNotificationCenter defaultCenter]

#endif

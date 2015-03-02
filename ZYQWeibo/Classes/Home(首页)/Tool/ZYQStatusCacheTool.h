//
//  ZYQStatusCacheTool.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//管理微博的缓存数据

#import <Foundation/Foundation.h>
#import "ZYQHomeStatusesParam.h"
@class ZYQStatus;
@interface ZYQStatusCacheTool : NSObject

/**
 *  缓存一条微博
 *
 *  @param status 需要缓存的微博数据
 */
+ (void)addStatus:(ZYQStatus *)status;

/**
 *  缓存N条微博
 *
 *  @param statusArray 需要缓存的微博数据
 */
+ (void)addStatuses:(NSArray *)statusArray;

/**
 *  根据请求参数获得微博数据
 *
 *  @param param 请求参数
 *
 *  @return 模型数组
 */
+ (NSArray *)statuesWithParam:(ZYQHomeStatusesParam *)param;

@end

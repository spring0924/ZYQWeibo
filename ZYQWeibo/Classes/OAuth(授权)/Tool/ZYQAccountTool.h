//
//  ZYQAccountTool.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-3.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//  账号管理工具类

#import <Foundation/Foundation.h>
#import "ZYQAccessTokenParam.h"
#import "ZYQAccessTokenResult.h"
@class ZYQAccount;
@interface ZYQAccountTool : NSObject
/**
 *  存储账号信息
 *
 *  @param account 需要存储的账号
 */
+(void)saveAccount:(ZYQAccount *)account;
/**
 *  返回所存储的账号信息
 *
 */
+(ZYQAccount *)account;
/**
 *  获得accessToken
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)accessTokenWithParam:(ZYQAccessTokenParam *)param success:(void (^)(ZYQAccessTokenResult *result))success failure:(void (^)(NSError *error))failure;

@end

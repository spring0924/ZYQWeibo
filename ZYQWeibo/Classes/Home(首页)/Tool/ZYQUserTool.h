//
//  ZYQUserTool.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYQUserInfoParam.h"
#import "ZYQUserInfoResult.h"

#import "ZYQUserUnreadCountParam.h"
#import "ZYQUserUnreadCountResult.h"
@interface ZYQUserTool : NSObject
/**
 *  加载用户的个人信息
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)userInfoWithParam:(ZYQUserInfoParam *)param success:(void (^)(ZYQUserInfoResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  加载用户的消息未读数
 */
+ (void)userUnreadCountWithParam:(ZYQUserUnreadCountParam *)param success:(void (^)(ZYQUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure;


@end

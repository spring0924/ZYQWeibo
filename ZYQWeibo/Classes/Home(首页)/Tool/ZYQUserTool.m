//
//  ZYQUserTool.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//用户业务处理类（工具类）

#import "ZYQUserTool.h"
#import "ZYQHttpTool.h"
#import "MJExtension.h"
@implementation ZYQUserTool

+ (void)userInfoWithParam:(ZYQUserInfoParam *)param success:(void (^)(ZYQUserInfoResult *))success failure:(void (^)(NSError *))failure
{
    [ZYQHttpTool getWithURL:@"https://api.weibo.com/2/users/show.json" params:param.keyValues success:^(id json) {
        if (success) {
            ZYQUserInfoResult *result = [ZYQUserInfoResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)userUnreadCountWithParam:(ZYQUserUnreadCountParam *)param success:(void (^)(ZYQUserUnreadCountResult *result))success failure:(void (^)(NSError *error))failure
{
    [ZYQHttpTool getWithURL:@"https://rm.api.weibo.com/2/remind/unread_count.json" params:param.keyValues success:^(id json) {
        if (success) {
            ZYQUserUnreadCountResult *result = [ZYQUserUnreadCountResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

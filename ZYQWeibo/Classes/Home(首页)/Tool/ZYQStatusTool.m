//
//  ZYQStatusTool.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQStatusTool.h"
#import "ZYQHttpTool.h"
#import "ZYQStatusCacheTool.h"
#import "MJExtension.h"
@implementation ZYQStatusTool
+ (void)homeStatusesWithParam:(ZYQHomeStatusesParam *)param success:(void (^)(ZYQHomeStatusesResult *))success failure:(void (^)(NSError *))failure
{
    // 1.先从缓存里面加载
    NSArray *statusArray = [ZYQStatusCacheTool statuesWithParam:param];
    if (statusArray.count) { // 有缓存
        // 传递了block
        if (success) {
            ZYQHomeStatusesResult *result = [[ZYQHomeStatusesResult alloc] init];
            result.statuses = statusArray;
            success(result);
        }
    } else {
        [ZYQHttpTool getWithURL:@"https://api.weibo.com/2/statuses/home_timeline.json" params:param.keyValues success:^(id json) {
            ZYQHomeStatusesResult *result = [ZYQHomeStatusesResult objectWithKeyValues:json];
            
            // 缓存
            [ZYQStatusCacheTool addStatuses:result.statuses];
            
            // 传递了block
            if (success) {
                success(result);
            }
        } failure:^(NSError *error) {
            if (failure) {
                failure(error);
            }
        }];
    }
}

+ (void)sendStatusWithParam:(ZYQSendStatusParam *)param success:(void (^)(ZYQSendStatusResult *))success failure:(void (^)(NSError *))failure
{
    [ZYQHttpTool postWithURL:@"https://api.weibo.com/2/statuses/update.json" params:param.keyValues success:^(id json) {
        if (success) {
            ZYQSendStatusResult *result = [ZYQSendStatusResult objectWithKeyValues:json];
            success(result);
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
}

@end

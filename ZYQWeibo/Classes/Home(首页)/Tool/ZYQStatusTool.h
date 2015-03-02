//
//  ZYQStatusTool.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZYQHomeStatusesParam.h"
#import "ZYQHomeStatusesResult.h"
#import "ZYQSendStatusParam.h"
#import "ZYQSendStatusResult.h"
@interface ZYQStatusTool : NSObject
/**
 *  加载首页的微博数据
 *
 *  @param param   请求参数
 *  @param success 请求成功后的回调
 *  @param failure 请求失败后的回调
 */
+ (void)homeStatusesWithParam:(ZYQHomeStatusesParam *)param success:(void (^)(ZYQHomeStatusesResult *result))success failure:(void (^)(NSError *error))failure;

/**
 *  发送一条微博
 */
+ (void)sendStatusWithParam:(ZYQSendStatusParam *)param success:(void (^)(ZYQSendStatusResult *result))success failure:(void (^)(NSError *error))failure;

@end

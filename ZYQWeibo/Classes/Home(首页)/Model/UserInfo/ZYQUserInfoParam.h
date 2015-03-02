//
//  ZYQUserInfoParam.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//封装加载用户信息的参数

#import "ZYQBaseParam.h"

@interface ZYQUserInfoParam : ZYQBaseParam
/**
 *  需要查询的用户ID。
 */
@property (nonatomic, strong) NSNumber *uid;

/**
 *  需要查询的用户昵称。
 */
@property (nonatomic, copy) NSString *screen_name;
@end

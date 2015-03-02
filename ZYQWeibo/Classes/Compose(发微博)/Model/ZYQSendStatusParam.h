//
//  ZYQSendStatusParam.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//封装发微博的参数


#import "ZYQBaseParam.h"

@interface ZYQSendStatusParam : ZYQBaseParam
/**
 *  要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
 */
@property (nonatomic, copy) NSString *status;

@end

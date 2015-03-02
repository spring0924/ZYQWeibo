//
//  ZYQBaseParam.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQBaseParam.h"
#import "ZYQAccount.h"
#import "ZYQAccountTool.h"
@implementation ZYQBaseParam
- (id)init
{
    if (self = [super init]) {
        self.access_token = [ZYQAccountTool account].access_token;
    }
    return self;
}

+ (instancetype)param
{
    return [[self alloc] init];
}
@end

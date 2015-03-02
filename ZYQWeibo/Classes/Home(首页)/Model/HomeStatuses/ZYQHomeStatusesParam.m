//
//  ZYQHomeStatusesParam.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQHomeStatusesParam.h"

@implementation ZYQHomeStatusesParam
- (NSNumber *)count
{
    return _count ? _count : @20;
}
@end

//
//  ZYQHomeStatusesResult.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQHomeStatusesResult.h"
#import "MJExtension.h"
#import "ZYQStatus.h"
@implementation ZYQHomeStatusesResult
- (NSDictionary *)objectClassInArray
{
    return @{@"statuses" : [ZYQStatus class]};
}
@end

//
//  ZYQAccountTool.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-3.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQAccountTool.h"
#import "ZYQAccount.h"
#import "ZYQHttpTool.h"
#import "MJExtension.h"
#define ZYQAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"account.data"]

@implementation ZYQAccountTool
+(void)saveAccount:(ZYQAccount *)account
{
    // 计算账号的过期时间
    NSDate *now = [NSDate date];
    account.expiresTime = [now dateByAddingTimeInterval:account.expires_in];
    
    [NSKeyedArchiver archiveRootObject:account toFile:ZYQAccountFile];
}

+ (ZYQAccount *)account
{
    // 取出账号
    ZYQAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZYQAccountFile];
    
    // 判断账号是否过期
    NSDate *now = [NSDate date];
    if ([now compare:account.expiresTime] == NSOrderedAscending) { // 还没有过期
        return account;
    } else { // 过期
        return nil;
    }
}

@end

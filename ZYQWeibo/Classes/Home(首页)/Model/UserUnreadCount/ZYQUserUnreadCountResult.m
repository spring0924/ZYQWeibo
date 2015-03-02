//
//  ZYQUserUnreadCountResult.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQUserUnreadCountResult.h"

@implementation ZYQUserUnreadCountResult
- (int)messageCount
{
    return self.cmt + self.mention_cmt + self.mention_status + self.dm;
}

- (int)count
{
    return self.messageCount + self.status + self.follower;
}

@end

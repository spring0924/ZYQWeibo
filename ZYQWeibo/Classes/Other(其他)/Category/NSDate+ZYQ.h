//
//  NSDate+ZYQ.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-3.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (ZYQ)
/**
 *  是否是今天
 */
-(BOOL)isToday;
/**
 *  是否为昨天
 */
-(BOOL)isYesterday;
/**
 *  是否为今年
 */
-(BOOL)isThisYear;
/**
 *  返回一个只有年月日的时间
 */
-(NSDate *)dateWithYMD;
/**
 *  获得与当前时间的差距
 */
-(NSDateComponents *)deltaWithNow;

@end

//
//  ZYQStatusFrame.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//一个cell对应一个IWStatusFrame对象

#import <Foundation/Foundation.h>
@class ZYQStatus;
@interface ZYQStatusFrame : NSObject
@property (nonatomic, strong) ZYQStatus *status;

/** 顶部的view */
@property (nonatomic, assign, readonly) CGRect topViewF;
/** 头像 */
@property (nonatomic, assign, readonly) CGRect iconViewF;
/** 会员图标 */
@property (nonatomic, assign, readonly) CGRect vipViewF;
/** 配图 */
@property (nonatomic, assign, readonly) CGRect photosViewF;
/** 昵称 */
@property (nonatomic, assign, readonly) CGRect nameLabelF;
/** 时间 */
@property (nonatomic, assign, readonly) CGRect timeLabelF;
/** 来源 */
@property (nonatomic, assign, readonly) CGRect sourceLabelF;
/** 正文\内容 */
@property (nonatomic, assign, readonly) CGRect contentLabelF;

/** 被转发微博的view(父控件) */
@property (nonatomic, assign, readonly) CGRect retweetViewF;
/** 被转发微博作者的昵称 */
@property (nonatomic, assign, readonly) CGRect retweetNameLabelF;
/** 被转发微博的正文\内容 */
@property (nonatomic, assign, readonly) CGRect retweetContentLabelF;
/** 被转发微博的配图 */
@property (nonatomic, assign, readonly) CGRect retweetPhotosViewF;

/** 微博的工具条 */
@property (nonatomic, assign, readonly) CGRect statusToolbarF;

/** cell的高度 */
@property (nonatomic, assign, readonly) CGFloat cellHeight;


@end

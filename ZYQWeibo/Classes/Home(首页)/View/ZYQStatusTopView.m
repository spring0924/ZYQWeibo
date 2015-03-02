//
//  ZYQStatusTopView.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQStatusTopView.h"
#import "ZYQStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "ZYQUser.h"
#import "ZYQReweetStatusView.h"
#import "ZYQStatus.h"
#import "ZYQPhotosView.h"
#import "ZYQPhoto.h"

@interface ZYQStatusTopView()
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) ZYQPhotosView *photosView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文\内容 */
@property (nonatomic, weak) UILabel *contentLabel;

/** 被转发微博的view(父控件) */
@property (nonatomic, weak) ZYQReweetStatusView *retweetView;
@end


@implementation ZYQStatusTopView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.设置图片
        self.userInteractionEnabled = YES;
        self.image = [UIImage resizedImageWithName:@"timeline_card_top_background"];
        self.highlightedImage = [UIImage resizedImageWithName:@"timeline_card_top_background_highlighted"];
        
        /** 2.头像 */
        UIImageView *iconView = [[UIImageView alloc] init];
        [self addSubview:iconView];
        self.iconView = iconView;
        
        /** 3.会员图标 */
        UIImageView *vipView = [[UIImageView alloc] init];
        vipView.contentMode = UIViewContentModeCenter;
        [self addSubview:vipView];
        self.vipView = vipView;
        
        /** 4.配图 */
        ZYQPhotosView *photosView = [[ZYQPhotosView alloc] init];
        [self addSubview:photosView];
        self.photosView = photosView;
        
        /** 5.昵称 */
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = ZYQStatusNameFont;
        nameLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        /** 6.时间 */
        UILabel *timeLabel = [[UILabel alloc] init];
        timeLabel.font = ZYQStatusTimeFont;
        timeLabel.textColor = ZYQColor(240, 140, 19);
        timeLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:timeLabel];
        self.timeLabel = timeLabel;
        
        /** 7.来源 */
        UILabel *sourceLabel = [[UILabel alloc] init];
        sourceLabel.font = ZYQStatusSourceFont;
        sourceLabel.textColor = ZYQColor(135, 135, 135);
        sourceLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:sourceLabel];
        self.sourceLabel = sourceLabel;
        
        /** 8.正文\内容 */
        UILabel *contentLabel = [[UILabel alloc] init];
        contentLabel.numberOfLines = 0;
        contentLabel.textColor = ZYQColor(39, 39, 39);
        contentLabel.font = ZYQStatusContentFont;
        contentLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:contentLabel];
        self.contentLabel = contentLabel;
        
        /** 9.添加被转发微博的view */
        ZYQReweetStatusView *retweetView = [[ZYQReweetStatusView alloc] init];
        [self addSubview:retweetView];
        self.retweetView = retweetView;
    }
    return self;
}

- (void)setStatusFrame:(ZYQStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    // 1.取出模型数据
    ZYQStatus *status = statusFrame.status;
    ZYQUser *user = status.user;
    
    // 2.头像
    [self.iconView setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageWithName:@"avatar_default_small"]];
    self.iconView.frame = self.statusFrame.iconViewF;
    
    // 3.昵称
    self.nameLabel.text = user.name;
    self.nameLabel.frame = self.statusFrame.nameLabelF;
    
    // 4.vip
    if (user.mbtype > 2) {
        self.vipView.hidden = NO;
        self.vipView.image = [UIImage imageWithName:[NSString stringWithFormat:@"common_icon_membership_level%d", user.mbrank]];
        self.vipView.frame = self.statusFrame.vipViewF;
        
        self.nameLabel.textColor = [UIColor orangeColor];
    } else {
        self.nameLabel.textColor = [UIColor blackColor];
        
        self.vipView.hidden = YES;
    }
    
    // 5.时间
    self.timeLabel.text = status.createdTime;
    CGFloat timeLabelX = self.statusFrame.nameLabelF.origin.x;
    CGFloat timeLabelY = CGRectGetMaxY(self.statusFrame.nameLabelF) + ZYQStatusCellBorder * 0.5;
    CGSize timeLabelSize = [status.createdTime sizeWithFont:ZYQStatusTimeFont];
    self.timeLabel.frame = (CGRect){{timeLabelX, timeLabelY}, timeLabelSize};
    
    // 6.来源
    self.sourceLabel.text = status.source;
    CGFloat sourceLabelX = CGRectGetMaxX(self.timeLabel.frame) + ZYQStatusCellBorder;
    CGFloat sourceLabelY = timeLabelY;
    CGSize sourceLabelSize = [status.source sizeWithFont:ZYQStatusSourceFont];
    self.sourceLabel.frame = (CGRect){{sourceLabelX, sourceLabelY}, sourceLabelSize};
    
    // 7.正文
    self.contentLabel.text = status.text;
    self.contentLabel.frame = self.statusFrame.contentLabelF;
    
    // 8.配图
    if (status.pic_urls.count) {
        self.photosView.hidden = NO;
        self.photosView.frame = self.statusFrame.photosViewF;
        self.photosView.photos = status.pic_urls;
    } else {
        self.photosView.hidden = YES;
    }
    
    // 9.被转发微博
    ZYQStatus *retweetStatus = status.retweeted_status;
    if (retweetStatus) {
        self.retweetView.hidden = NO;
        self.retweetView.frame = self.statusFrame.retweetViewF;
        
        // 传递模型数据
        self.retweetView.statusFrame = self.statusFrame;
    } else {
        self.retweetView.hidden = YES;
    }
    
}

@end

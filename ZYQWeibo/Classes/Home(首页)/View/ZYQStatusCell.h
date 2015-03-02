//
//  ZYQStatusCell.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
// 展示微博的cell

#import <UIKit/UIKit.h>
@class ZYQStatusFrame;
@interface ZYQStatusCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) ZYQStatusFrame *statusFrame;

@end

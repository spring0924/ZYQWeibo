//
//  ZYQComposeToolbar.h
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-4.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZYQComposeToolbar;

typedef enum {
    ZYQComposeToolbarButtonTypeCamera,
    ZYQComposeToolbarButtonTypePicture,
    ZYQComposeToolbarButtonTypeMention,
    ZYQComposeToolbarButtonTypeTrend,
    ZYQComposeToolbarButtonTypeEmotion
} ZYQComposeToolbarButtonType;

@protocol ZYQComposeToolbarDelegate <NSObject>
@optional
- (void)composeToolbar:(ZYQComposeToolbar *)toolbar didClickedButton:(ZYQComposeToolbarButtonType)buttonType;
@end

@interface ZYQComposeToolbar : UIView
@property (weak, nonatomic) id<ZYQComposeToolbarDelegate> delegate;
@end

//
//  UIImage+ZYQ.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-2.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "UIImage+ZYQ.h"

@implementation UIImage (ZYQ)
+(UIImage *)imageWithName:(NSString *)name{
    if (iOS7) {
        NSString *newName = [name stringByAppendingString:@"_os7"];
        UIImage *image = [UIImage imageNamed:newName];
        if (image == nil) {
            //没有_os7后缀的图片
            image = [UIImage imageNamed:name];
        }
        return image;
    }
    //非iOS7
    return [UIImage imageNamed:name];
}


+(UIImage *)resizedImageWithName:(NSString *)name{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height * 0.5];
}
+ (UIImage *)resizedImageWithName:(NSString *)name left:(CGFloat)left top:(CGFloat)top
{
    UIImage *image = [self imageWithName:name];
    return [image stretchableImageWithLeftCapWidth:image.size.width * left topCapHeight:image.size.height * top];
}
@end

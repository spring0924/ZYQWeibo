//
//  ZYQNewfeatureViewController.m
//  ZYQWeibo
//
//  Created by YuQuan Zhang on 15-2-1.
//  Copyright (c) 2015年 YuQuan Zhang. All rights reserved.
//

#import "ZYQNewfeatureViewController.h"
#import "ZYQTabBarViewController.h"
#define ZYQNewfeatureImageCount 3

@interface ZYQNewfeatureViewController ()<UIScrollViewDelegate>
@property(nonatomic,weak) UIPageControl *pageControl;
@end

@implementation ZYQNewfeatureViewController



- (void)viewDidLoad
{
    [super viewDidLoad];
    //1.添加UIScrollView
    [self setupScrollView];
    //2.添加pageControll
    [self setupPageControl];
}

//添加pageControll
-(void)setupPageControl{
    //1.添加
    UIPageControl *pageControl =[[UIPageControl alloc]init];
    pageControl.numberOfPages = ZYQNewfeatureImageCount;
    CGFloat centerX = self.view.frame.size.width * 0.5;
    CGFloat centerY = self.view.frame.size.height - 30;
    pageControl.center = CGPointMake(centerX, centerY);
    pageControl.bounds = CGRectMake(0, 0, 100, 30);
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    self.pageControl = pageControl;
    //2.设置圆点颜色
    //2.1当前选择的圆点颜色
    pageControl.currentPageIndicatorTintColor =ZYQColor(253, 98, 42);
    //2.2默认圆点颜色
    pageControl.pageIndicatorTintColor = ZYQColor(189, 189, 189);
    
    
}

/**
 *  添加UISrollView
 */
- (void)setupScrollView
{
   //1.添加UIScrollView
    UIScrollView *scrollView = [[UIScrollView alloc]init];
    scrollView.frame = self.view.bounds;
    scrollView.delegate = self;
    [self.view addSubview:scrollView];
    //2.添加图片
    CGFloat imageW = scrollView.frame.size.width;
    CGFloat imageH = scrollView.frame.size.height;
    for (int index = 0; index<ZYQNewfeatureImageCount; index++) {
        UIImageView *imageView = [[UIImageView alloc]init];
        //设置图片
        NSString *name = [NSString stringWithFormat:@"new_feature_%d", index+1];
        imageView.image = [UIImage imageWithName:name];
        //设置frame
        CGFloat imageX = index * imageW;
        imageView.frame = CGRectMake(imageX, 0, imageW, imageH);
        [scrollView addSubview:imageView];
        //在最后一张图片上添加按钮
        if (index == ZYQNewfeatureImageCount - 1) {
            [self setupLastImageView:imageView];
        }
    }
    //3.设置滚动的内容尺寸
    scrollView.contentSize = CGSizeMake(imageW*ZYQNewfeatureImageCount, 0);
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    scrollView.bounces = NO;
}

/**
 *  添加内容到最后一个图片
 */
- (void)setupLastImageView:(UIImageView *)imageView
{
   //0.让imageView能和用户交互
    imageView.userInteractionEnabled = YES;
    //1.添加开始按钮
    UIButton *startButton = [[UIButton alloc]init];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button"] forState:UIControlStateNormal];
    [startButton setBackgroundImage:[UIImage imageWithName:@"new_feature_finish_button_highlighted"] forState:UIControlStateHighlighted];
    //2.设置frame
     CGFloat centerX = imageView.frame.size.width*0.5;
     CGFloat centerY = imageView.frame.size.height*0.6;
     startButton.center = CGPointMake(centerX, centerY);
     startButton.bounds = (CGRect){CGPointZero,startButton.currentBackgroundImage.size};
     //3.设置文字
     [startButton setTitle:@"开始微博" forState:UIControlStateNormal];
     [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
     [startButton addTarget:self action:@selector(startWeibo) forControlEvents:UIControlEventTouchUpInside];
     [imageView addSubview:startButton];
     //4.添加checkbox
     UIButton *checkbox = [[UIButton alloc]init];
     checkbox.selected = YES;//默认选中状态
     [checkbox setTitle:@"分享给大家" forState:UIControlStateNormal];
     [checkbox setImage:[UIImage imageWithName:@"new_feature_share_false"] forState:UIControlStateNormal];
     [checkbox setImage:[UIImage imageWithName:@"new_feature_share_true"] forState:UIControlStateSelected];
     checkbox.bounds = CGRectMake(0, 0, 200, 50);
     CGFloat checkboxCenterX = centerX;
     CGFloat checkboxCenterY = imageView.frame.size.height * 0.5;
     checkbox.center = CGPointMake(checkboxCenterX, checkboxCenterY);
     [checkbox setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
     checkbox.titleLabel.font = [UIFont systemFontOfSize:15];
     [checkbox addTarget:self action:@selector(checkboxClick:) forControlEvents:UIControlEventTouchUpInside];
  
     checkbox.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    
     [imageView addSubview:checkbox];
     }
/**
 *  开始微博
 */
- (void)startWeibo
{
    // 显示状态栏
    [UIApplication sharedApplication].statusBarHidden = NO;
    // 切换窗口的根控制器
    self.view.window.rootViewController = [[ZYQTabBarViewController alloc] init];
}

- (void)checkboxClick:(UIButton *)checkbox
{
    checkbox.selected = !checkbox.isSelected;
}

/**
 *  只要UIScrollView滚动了,就会调用
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 1.取出水平方向上滚动的距离
    CGFloat offsetX = scrollView.contentOffset.x;
    
    // 2.求出页码
    double pageDouble = offsetX / scrollView.frame.size.width;
    int pageInt = (int)(pageDouble + 0.5);
    self.pageControl.currentPage = pageInt;
}






@end

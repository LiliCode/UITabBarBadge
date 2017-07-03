//
//  UITabBar+Badge.m
//  linlin2
//
//  Created by LiliEhuu on 17/7/3.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "UITabBar+Badge.h"
#import <objc/runtime.h>


#define getBadgeTag(index) (index + 1000)

static char *kBadgeViewSize = "kBadgeViewSize";
static char *kBadgeViewColor = "kBadgeViewColor";

@implementation UITabBar (Badge)

- (void)setBadgeSize:(CGSize)badgeSize
{
    objc_setAssociatedObject(self, &kBadgeViewSize, [NSValue valueWithCGSize:badgeSize], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)badgeSize
{
    return [objc_getAssociatedObject(self, &kBadgeViewSize) CGSizeValue];
}

- (void)setBadgeColor:(UIColor *)badgeColor
{
    objc_setAssociatedObject(self, &kBadgeViewColor, badgeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeColor
{
    return objc_getAssociatedObject(self, &kBadgeViewColor);
}


- (void)showBadgeOnItemIndex:(NSUInteger)index
{
    //先移除对应的badge
    [self removeBadgeOnItemIndex:index animated:NO];
    
    //默认值计算
    CGSize badgeSize = self.badgeSize;
    if (__CGSizeEqualToSize(badgeSize, CGSizeZero)) //如果为空
    {
        badgeSize = CGSizeMake(10.0f, 10.0f);   //设置默认大小
    }
    
    if (!self.badgeColor)
    {
        self.badgeColor = [UIColor redColor];   //设置默认颜色-红色
    }
    
    //badge
    UIView *badgeView = [[UIView alloc] init];
    badgeView.tag = getBadgeTag(index);
    badgeView.backgroundColor = self.badgeColor;
    badgeView.layer.cornerRadius = badgeSize.width / 2.0f;
    
    //获取barButtonView
    UIView *barButtonView = [self barButtonViewAtIndex:index];
    //利用XCode的视图图层展示器找到UITabBarSwappableImageView对象
    UIView *iconView = nil;
    for (UIView *swappableImageView in barButtonView.subviews)
    {
        if ([swappableImageView isKindOfClass:[UIImageView class]])
        {
            iconView = swappableImageView;
            break;
        }
    }
    
    CGSize iconSize = iconView.frame.size;
    //设置红点frame
    badgeView.frame = CGRectMake(iconSize.width + iconView.frame.origin.x, iconView.frame.origin.y - badgeSize.height / 2.0f, badgeSize.width, badgeSize.height);
    
    //添加红点到UIBarButtonView上面，在图片的右上角
    [barButtonView addSubview:badgeView];
}

- (void)hideBadgeOnItemIndex:(NSUInteger)index animated:(BOOL)animated
{
    [self removeBadgeOnItemIndex:index animated:animated];
}

- (void)removeBadgeOnItemIndex:(NSUInteger)index animated:(BOOL)animated
{
    //获取barButtonView
    UIView *barButtonView = [self barButtonViewAtIndex:index];
    //删除红点
    for (UIView *badgeView in barButtonView.subviews)
    {
        if (badgeView.tag == getBadgeTag(index))
        {
            if (animated)
            {
                //显示小时动画
                [UIView animateWithDuration:.2 animations:^{
                    badgeView.transform = CGAffineTransformScale(badgeView.transform, 2, 2);
                    badgeView.alpha = 0;
                } completion:^(BOOL finished) {
                    [badgeView removeFromSuperview];
                }];
            }
            
            break;
        }
    }
}


- (UIView *)barButtonViewAtIndex:(NSUInteger)index
{
    //获取index对应的UIBarButtonItem对象
    UIBarButtonItem *item = (UIBarButtonItem *)[self.items objectAtIndex:index];
    //通过runtime和KVC找到UIBarBottunItem的View
    return [item valueForKey:@"view"];
}



@end




//
//  UITabBar+Badge.h
//  linlin2
//
//  Created by LiliEhuu on 17/7/3.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//
//  UITabBar+Badge 在相应的UIBarButtonItem上面显示提示红点
//  参考资料：http://www.jianshu.com/p/8331d27318ab
//


#import <UIKit/UIKit.h>

@interface UITabBar (Badge)

@property (assign , nonatomic) CGSize badgeSize;    //小红点的大小
@property (strong , nonatomic) UIColor *badgeColor; //小红点颜色


/**
 显示提示的小红点

 @param index UITabBarItem 的索引
 */
- (void)showBadgeOnItemIndex:(NSUInteger)index;

/**
 隐藏提示的小红点
 
 @param index UITabBarItem 的索引
 @param animated 消失动画
 */
- (void)hideBadgeOnItemIndex:(NSUInteger)index animated:(BOOL)animated;


@end

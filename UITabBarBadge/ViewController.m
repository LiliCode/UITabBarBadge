//
//  ViewController.m
//  UITabBarBadge
//
//  Created by LiliEhuu on 17/7/3.
//  Copyright © 2017年 LiliEhuu. All rights reserved.
//

#import "ViewController.h"
#import "UITabBar+Badge.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
}

- (IBAction)showBadge:(UIButton *)sender
{
    [self.tabBarController.tabBar showBadgeOnItemIndex:0];
}

- (IBAction)hideBadge:(UIButton *)sender
{
    [self.tabBarController.tabBar hideBadgeOnItemIndex:0 animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


@end

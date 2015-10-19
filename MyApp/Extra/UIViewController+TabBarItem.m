//
//  UIViewController+TabBarItem.m
//  Lofter
//
//  Created by qianfeng001 on 15/9/22.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "UIViewController+TabBarItem.h"

@implementation UIViewController (TabBarItem)

+ (instancetype)viewControllTitle:(NSString*)title normalImage:(NSString*)normalimageName selectImageName:(NSString*)selectImageName
{
    UIViewController * viewController = [[[self class]alloc]init];
    UIImage *selectImage =[UIImage imageNamed:selectImageName];
    selectImage = [selectImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:title image:[UIImage imageNamed:normalimageName] selectedImage:selectImage];
    
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor darkGrayColor]} forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor cyanColor]} forState:UIControlStateSelected];
    
    viewController.tabBarItem = tabBarItem;
    
    return viewController;
}

@end

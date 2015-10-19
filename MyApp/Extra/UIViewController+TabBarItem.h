//
//  UIViewController+TabBarItem.h
//  Lofter
//
//  Created by qianfeng001 on 15/9/22.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TabBarItem)

+ (instancetype)viewControllTitle:(NSString*)title normalImage:(NSString*)normalimageName selectImageName:(NSString*)selectImageName;

@end

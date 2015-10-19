//
//  UIButton+Custom.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Custom)

+ (UIButton*)setbutttonWithTitle:(NSString*)title image:(NSString*)image selectImage:(NSString*)selectImage target:(id)target action:(SEL)action selected:(BOOL)selected tag:(NSInteger)tag;

+ (UIButton*)setbarButttonWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action tag:(NSInteger)tag labelWithButton:(BOOL)labelWithButton;
+ (UIButton*)setfunctionButtonWithTitle:(NSString*)title height:(float)height image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action;
@end

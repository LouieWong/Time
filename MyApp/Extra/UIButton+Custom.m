//
//  UIButton+Custom.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "UIButton+Custom.h"
#import "helper.h"
#import "Masonry.h"
@implementation UIButton (Custom)

+ (UIButton*)setbutttonWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action selected:(BOOL)selected tag:(NSInteger)tag
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    UIImage *tmpimage = [[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ];
    [button setImage:tmpimage forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = lightGray;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.selected = selected;
    button.tag = tag;
    UILabel *label = [[UILabel alloc]init];
    label.tag = button.tag+100;
    [button addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(button.mas_left).offset(3);
        make.right.equalTo(button.mas_right).offset(-3);
        make.bottom.equalTo(button.mas_bottom).offset(-2);
        make.height.equalTo(@2);
    }];

    return button;
}
+ (UIButton*)setbarButttonWithTitle:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action tag:(NSInteger)tag labelWithButton:(BOOL)labelWithButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button setTintColor:[UIColor whiteColor]];
    button.backgroundColor = lightGray;
    button.layer.cornerRadius = 3.0;
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:14]];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.tag = tag;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0,-5,0, 0)];
    
    if (labelWithButton == YES){
        
        UILabel *label = [[UILabel alloc]init];
        label.tag = button.tag+100;
//    label.backgroundColor = [UIColor whiteColor];
        label.textColor = [UIColor whiteColor];
        [label setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:12]];
        [button addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.baseline.equalTo(button.mas_baseline);
            make.right.equalTo(button.mas_right).offset(-3);
            make.bottom.equalTo(button.mas_bottom).offset(-2);
            make.top.equalTo(button.mas_top).offset(2);
            make.width.equalTo(@15);
        }];
    }
    
    return button;

}
+ (UIButton*)setfunctionButtonWithTitle:(NSString*)title height:(float)height image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, height,height);
    [button setTintColor:[UIColor blackColor]];
    [button setTitle:title forState:UIControlStateNormal];
    button.backgroundColor = deepblack;
    button.titleLabel.font = [UIFont boldSystemFontOfSize:16];
//    button.layer.cornerRadius = 3.0;
//    button.layer.borderWidth = 3.0;
//    button.layer.borderColor = [UIColor whiteColor].CGColor;
    [button setImage:[[UIImage imageNamed:image]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal ] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:selectImage] forState:UIControlStateSelected];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(height/0.618));
        make.height.equalTo(@(height));
    }];
    return button;
}
@end

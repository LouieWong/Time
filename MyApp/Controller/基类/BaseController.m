//
//  MainController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "BaseController.h"
#import "index_AnimationVideoController.h"
#import "todayNewsController.h"
#import "favoriteController.h"
#import "SettingController.h"
#import "assortmentController.h"
#import "UIButton+Custom.h"

@interface BaseController ()




@end

@implementation BaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initUI];
    [self fetchData];

}

#pragma mark - 界面搭建
- (void)initUI
{
//    [self addAnimation];
//    self.navigationController.navigationBar.tintColor = deepblack;
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
    [self preferredStatusBarStyle];
}


-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - 动画
- (void)addAnimation
{
    [UIView beginAnimations:@"Curl"context:nil];//动画开始
    [UIView setAnimationDuration:0.30];
    [UIView setAnimationDelegate:self];
}

#pragma mark - 数据加载
- (void)fetchData
{
    [self fetchWebData];
}
- (void)fetchWebData
{
    
}
- (NSString*)getCurrentTime
{
    NSDate  *senddate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *locationString = [formatter stringFromDate:senddate];
    return locationString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
    



@end

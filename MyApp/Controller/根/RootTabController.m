//
//  RootTabController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "RootTabController.h"
#import "UIViewController+TabBarItem.h"
#import "UIButton+Custom.h"
#import "NavViewController.h"
#import "ContainerViewController.h"
#import "index_AnimationVideoController.h"
#import "todayNewsController.h"
#import "favoriteController.h"
#import "SettingController.h"
#import "assortmentController.h"
#import "Masonry.h"
#import "assortmentChildController.h"

#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
#import "FiveViewController.h"  
#import "SixViewController.h"   
#import "SevenViewController.h"
#import "EightViewController.h"
#import "NineViewController.h"
#import "TenViewController.h"
#import "ElevenViewController.h"
#import "TwelveViewController.h"


@interface RootTabController ()

@property (nonatomic) UIButton *selectedBtn;
//@property (nonatomic)UIView *customTabbarView;

@property (nonatomic)UIButton *toiletTimeButton;
@property (nonatomic)UIButton *todayNewsButton;
@property (nonatomic)UIButton *favoriteButton;
@property (nonatomic)UIButton *assortmentButton;
@property (nonatomic)UIButton *settingButton;
@property (nonatomic)NSArray *buttonArray;
@end

@implementation RootTabController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = backGroundColor;
    [self initUI];
    
}
- (void)initUI
{
    
    [self addViewControllers];
    [self customTabbar];
//    [self addAnimationLanchImage];
    self.selectedIndex = _todayNewsButton.tag - 101;
    [self buttonColor:_todayNewsButton];
}
- (void)addViewControllers
{
//    OneViewController *one = [[OneViewController alloc]init];
//    one.title = @"用户推荐日报";
//    TwoViewController *two = [[TwoViewController alloc]init];
//    two.title = @"日常心理学";
//    ThreeViewController *three =[[ThreeViewController alloc]init];
//    three.title =@"电影日报";
//    FourViewController *four =[[FourViewController alloc]init];
//    four.title =@"不许无聊";
//    FiveViewController *five =[[FiveViewController alloc]init];
//    five.title =@"设计日报";
//    SixViewController *six =[[SixViewController alloc]init];
//    six.title =@"大公司日报";
//    SevenViewController *seven =[[SevenViewController alloc]init];
//    seven.title =@"互联网安全";
//    EightViewController *eight =[[EightViewController alloc]init];
//    eight.title =@"开始游戏";
//    NineViewController *nine =[[NineViewController alloc]init];
//    nine.title =@"音乐日报";
//    TenViewController *ten =[[TenViewController alloc]init];
//    ten.title =@"动漫日报";
//    ElevenViewController *eleven =[[ElevenViewController alloc]init];
//    eleven.title =@"体育日报";
//    TwelveViewController *twelve =[[TwelveViewController alloc]init];
//    twelve.title =@"财经日报";
//    
//    ContainerViewController  *container = [[ContainerViewController alloc]init];
//    container.viewControllers = @[one,three,four,five,six,seven,eight,nine,ten,eleven,twelve];
    
    
    
    
    index_AnimationVideoController *toileTimeVC = [index_AnimationVideoController viewControllTitle:@"往期" normalImage:nil selectImageName:nil];
    UINavigationController *toileTimeNav = [[UINavigationController alloc]initWithRootViewController:toileTimeVC];
    
    todayNewsController *todayNewsVC = [todayNewsController viewControllTitle:@"今日" normalImage:nil selectImageName:nil];
    UINavigationController *todayNewsNav = [[UINavigationController alloc]initWithRootViewController:todayNewsVC];
    
    assortmentController * assortmentVC = [assortmentController viewControllTitle:@"分类" normalImage:nil selectImageName:nil];
//    NavViewController *assortmentNav = [[NavViewController alloc]initWithRootViewController:container];
    UINavigationController *assortmentNav = [[UINavigationController alloc]initWithRootViewController:assortmentVC];

    
    favoriteController *favoriteVC = [favoriteController viewControllTitle:@"收藏" normalImage:nil selectImageName:nil];
    UINavigationController *favoriteNav = [[UINavigationController alloc]initWithRootViewController:favoriteVC];
    
    SettingController *settingVC = [SettingController viewControllTitle:@"设置" normalImage:nil selectImageName:nil];
    UINavigationController *settingNav = [[UINavigationController alloc]initWithRootViewController:settingVC];
    
    self.viewControllers = @[toileTimeNav,todayNewsNav,assortmentNav,favoriteNav,settingNav];
}

- (void)customTabbar
{
    

    [self.tabBar removeFromSuperview];
    
    self.customTabbarView = [[UIView alloc]init];
    _customTabbarView.backgroundColor = lightGray;
    _customTabbarView.userInteractionEnabled = YES;
    [self.view addSubview:_customTabbarView];
    
    [_customTabbarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@49);
    }];

    
    //Tabbar五个按钮
    self.toiletTimeButton = [UIButton setbutttonWithTitle:@"小影"image:@"" selectImage:nil target:self action:@selector(toiletTimeButtonClick:) selected:NO tag:101];
    self.todayNewsButton = [UIButton setbutttonWithTitle:@"小报" image:@"" selectImage:nil target:self action:@selector(todayNewsButtonClick:) selected:YES tag:102];
    self.assortmentButton = [UIButton setbutttonWithTitle:@"分类" image:@"" selectImage:nil target:self action:@selector(assortmentButtonClick:) selected:NO tag:103];
    _assortmentButton.backgroundColor = cyanGreen;
    self.favoriteButton = [UIButton setbutttonWithTitle:@"喜爱" image:@"" selectImage:nil target:self action:@selector(favoriteButtonClick:) selected:NO tag:104];
    self.settingButton = [UIButton setbutttonWithTitle:@"设置" image:@"" selectImage:nil target:self action:@selector(settingButtonClick:) selected:NO tag:105];
    [self.customTabbarView addSubview:_toiletTimeButton];
    [_customTabbarView addSubview:_todayNewsButton];
    [_customTabbarView addSubview:_assortmentButton];
    [_customTabbarView addSubview:_favoriteButton];
    [_customTabbarView addSubview:_settingButton];
    
    
    //设置约束
    int padding = self.view.frame.size.width/5;
    [_assortmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_customTabbarView.mas_centerX);
        make.width.equalTo(@(padding));
        make.top.equalTo(_customTabbarView.mas_top);
        make.bottom.equalTo(_customTabbarView.mas_bottom);
        
    }];
    [_todayNewsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_assortmentButton.mas_width);
        make.right.equalTo(_assortmentButton.mas_left);
        make.top.equalTo(_assortmentButton.mas_top);
        make.bottom.equalTo(_assortmentButton.mas_bottom);
    }];
    [_toiletTimeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_assortmentButton.mas_width);
        make.right.equalTo(_todayNewsButton.mas_left);
        make.top.equalTo(_assortmentButton.mas_top);
        make.bottom.equalTo(_assortmentButton.mas_bottom);
    }];
    [_favoriteButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_assortmentButton.mas_width);
        make.left.equalTo(_assortmentButton.mas_right);
        make.top.equalTo(_assortmentButton.mas_top);
        make.bottom.equalTo(_assortmentButton.mas_bottom);
    }];
    [_settingButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(_assortmentButton.mas_width);
        make.left.equalTo(_favoriteButton.mas_right);
        make.top.equalTo(_assortmentButton.mas_top);
        make.bottom.equalTo(_assortmentButton.mas_bottom);
    }];


    
}

- (void)toiletTimeButtonClick:(UIButton*)button
{
    [self resetButtonStatus];
    _toiletTimeButton.selected = YES;
    [self buttonColor:_toiletTimeButton];
    self.selectedIndex = _toiletTimeButton.tag - 101;
}
- (void)todayNewsButtonClick:(UIButton*)button
{
    [self resetButtonStatus];
    _todayNewsButton.selected = YES;
    [self buttonColor:_todayNewsButton];
    self.selectedIndex = _todayNewsButton.tag - 101;
}
- (void)assortmentButtonClick:(UIButton*)button
{
    [self resetButtonStatus];
    _assortmentButton.selected = YES;
    [self buttonColor:_assortmentButton];
    self.selectedIndex = _assortmentButton.tag - 101;
}
- (void)favoriteButtonClick:(UIButton*)button
{
    [self resetButtonStatus];
    _favoriteButton.selected = YES;
    [self buttonColor:_favoriteButton];
    self.selectedIndex = _favoriteButton.tag - 101;
}
- (void)settingButtonClick:(UIButton*)button
{
    [self resetButtonStatus];
    _settingButton.selected = YES;
    [self buttonColor:_settingButton];
    self.selectedIndex = _settingButton.tag - 101;
}

- (void)resetButtonStatus
{
    for (int index = 0; index < self.viewControllers.count; index++) {
        UIButton *button =  (UIButton*)[self.customTabbarView viewWithTag:101+index];
        button.selected = NO;
        [self buttonColor:button];
    }
    
    
}
- (void)buttonColor:(UIButton*)btn
{
    UILabel *label = (UILabel*)[btn viewWithTag:btn.tag+100];
    if (btn.tag == 103) {
    btn.backgroundColor = cyanGreen;
    }else{
        if (btn.selected == NO) {
            btn.backgroundColor = lightGray;
            label.backgroundColor = btn.backgroundColor;
        }else{
            btn.backgroundColor = deepblack;
            label.backgroundColor = cyanGreen;
        }

    }
}

- (void)addAnimationLanchImage
{
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"Welcome.jpg"]];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = image;
    [self.view addSubview:imageView];
    [UIView animateWithDuration:3.5 animations:^{
        imageView.alpha = 0.0 ;
    } completion:^(BOOL finished) {
        [imageView removeFromSuperview];
    }];
}


//隐藏自定义Tabbar

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  assortmentController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "assortmentController.h"
#import "helper.h"
#import "AFNetworking.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Blur.h"
#import "OneViewController.h"
#import "TwoViewController.h"
#import "ThreeViewController.h"
#import "FourViewController.h"
//定义球的大小
#define BALL_WIDTH   60
#define BALL_HEIGHT  60

#define BASE_TAG     100

//必应
#define bingImange @"http://appserver.m.bing.net/BackgroundImageService/TodayImageService.svc/GetTodayImage?dateOffset=0&urlEncodeHeaders=true&osName=windowsPhone&osVersion=8.10&orientation=480x800&deviceName=WP8&mkt=zh-CN"
//定义屏幕宽高
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

//生成一个自定义的颜色
//#define randomColor   (arc4random()%256/255.0)


@interface assortmentController ()

@property (nonatomic)BOOL isShowInWinidow;
@property (nonatomic)UIImageView *backImageView;
@property (nonatomic)UIImage *originImage;
@property (nonatomic)UIImage *blurImage;

@end

@implementation assortmentController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor yellowColor];
    [self fetchImageData];
    self.navigationItem.title = self.title;
    self.navigationController.navigationBar.translucent = NO;
}
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}
- (void)initUI
{
    [super initUI];
    
    
    _backImageView = [[UIImageView alloc]init];
    _backImageView.userInteractionEnabled = YES;
    [self.view addSubview:_backImageView];
    [_backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self createFourBalls];
    [self createButton];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self showBall];
    _isShowInWinidow = YES;
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self hideBall];
    _isShowInWinidow = NO;
    _backImageView.image = _blurImage;
}

- (void)createFourBalls
{
    CGFloat padding = (SCREEN_WIDTH-4*BALL_WIDTH)/5;
    NSArray *array = @[@"电影",@"音乐",@"二次元",@"游戏"];
    for (int index = 0; index < 4; index++) {
        UIButton *ball = [UIButton buttonWithType:UIButtonTypeCustom];
        ball.frame =CGRectMake(padding+(BALL_WIDTH+padding)*index,SCREEN_HEIGHT, BALL_WIDTH, BALL_HEIGHT);
        [ball setTitle:array[index] forState:UIControlStateNormal];
        [ball setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        ball.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        ball.backgroundColor = randomColor;
        ball.layer.cornerRadius = BALL_WIDTH/2;
        ball.tag = index+BASE_TAG;
        [ball addTarget:self action:@selector(ballClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.backImageView addSubview:ball];
    }
}
- (void)ballClick:(UIButton*)ball
{
    switch (ball.tag) {
        case BASE_TAG:{
            OneViewController *controller = [[OneViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case BASE_TAG+1:{
            TwoViewController *controller = [[TwoViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case BASE_TAG+2:{
            ThreeViewController *controller = [[ThreeViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case BASE_TAG+3:{
            FourViewController *controller = [[FourViewController alloc]init];
            [self.navigationController pushViewController:controller animated:YES];

        }
            break;

        default:
            break;
    }
}

- (void)createButton
{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeInfoLight];
    button.tintColor = [UIColor whiteColor];
//    button.center = CGPointMake(SCREEN_WIDTH/2, 80);
    button.backgroundColor = [UIColor clearColor];
//    [button setTitle:@"c" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(moveBall:) forControlEvents:UIControlEventTouchUpInside];
    [self.backImageView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.right.equalTo(self.view.mas_right);
        make.width.equalTo(@35);
        make.height.equalTo(@35);
    }];
}


- (void)moveBall:(UIButton*)button
{
    if (_isShowInWinidow) {
        [self hideBall];
        _isShowInWinidow = NO;
        _backImageView.image = _originImage;

    }else{
        [self showBall];
        _isShowInWinidow = YES;
        _backImageView.image = _blurImage;
    }

}

- (void)showBall
{
    for (int index = 0; index < 4; index++) {
        UIView *ballView = [self.view viewWithTag:index+BASE_TAG];
        
        //1:duration :动画的持续时间，单位秒
        //2:delay:动画延迟多长时间开始 单位秒
        //3:Damping 阻尼，取值范围0～1，一般 < 0.7 晃动比较厉害，为1不会有弹簧效果
        //4:Velocity:初始速度，单位 points/秒，一般设置为0就可以了
        //5:options:动画的一些属性，设置速度的曲线，或者翻转的方式
        //6:animations :动画内容
        //7:complete:动画结束时回调的block
        
        [UIView animateWithDuration:0.5 delay:0.01*index usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            CGPoint center = ballView.center;
            //            CGPoint newCenter = CGPointMake(center.x, center.y - 300);
            //            ballView.center = newCenter;
            
            //            struct CGAffineTransform {
            //                CGFloat a, b, c, d;
            //                CGFloat tx, ty;
            //            };
            
            //ad缩放 bc旋转 tx,ty位移，基础的2D矩阵
            //旋转，参数指定为弧度，M_PI <－> 180
            //CGAffineTransformMakeRotation(<#CGFloat angle#>)
            
            //缩放 ，sx：指x轴缩放的比例,sy 在y轴上的缩放比例
            //CGAffineTransformMakeScale(<#CGFloat sx#>, <#CGFloat sy#>)
            //平移 tx：在x轴上平移  ty 是在y上平移
            //CGAffineTransformMakeTranslation(<#CGFloat tx#>, <#CGFloat ty#>)
            
            //指定在y轴上 平移
            ballView.transform = CGAffineTransformMakeTranslation(0, -300);
            
            
        } completion:^(BOOL finished) {
            
        }];
    }
}

- (void)hideBall
{
    for (int index = 0; index < 4; index++) {
        UIView *ballView = [self.view viewWithTag:index+BASE_TAG];
        
        [UIView animateWithDuration:0.5 delay:0.01*index usingSpringWithDamping:0.5 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            //            CGPoint center = ballView.center;
            //            CGPoint newCenter = CGPointMake(center.x, center.y + 300);
            //            ballView.center = newCenter;
            
            //CGAffineTransformIdentity 指定一个矩阵，
            //让你的view回到最原始的状态，没有缩放，没有旋转，没有平移
            ballView.transform = CGAffineTransformIdentity;
        } completion:^(BOOL finished) {
   
        }];
    }
    
}
#pragma mark - 加载数据 
- (void)fetchImageData
{
    [_backImageView sd_setImageWithURL:[NSURL URLWithString:bingImange] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        _originImage = _backImageView.image;
        _backImageView.image = [UIImage setBlurImage:_backImageView.image quality:0.1 blurred:0.6];
        _blurImage = _backImageView.image;
    }];
}


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

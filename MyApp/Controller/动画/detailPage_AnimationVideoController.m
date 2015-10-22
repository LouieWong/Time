//
//  AnimationVideoController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/11.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "detailPage_AnimationVideoController.h"
#import "KRVideoPlayerController.h"
#import "UIImageView+WebCache.h"
#import "UIImage+Blur.h"
#import "Masonry.h"
#import "helper.h"
#import "RootTabController.h"
#import "infoAnimationDetailCell.h"
@interface detailPage_AnimationVideoController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic) KRVideoPlayerController *player;
@property (nonatomic) UIImageView *imageView;
@property (nonatomic) UIButton *playerButton;

@property (nonatomic) UITableView *detailTableView;
@end

@implementation detailPage_AnimationVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.videoSource_AnimationVideoModel = self.anime_AnimationVideoModel.VideoSource;
    self.view.backgroundColor = backGroundColor;
    
    [self initUI];
}
- (void)initUI
{
    
    [self createPlayer];
    [self createDetailTableView];
}
- (void)createDetailTableView
{
    self.detailTableView = [[UITableView alloc]init];
    _detailTableView.delegate = self;
    _detailTableView.dataSource = self;
    [self.view addSubview:_detailTableView];
    _detailTableView.rowHeight = UITableViewAutomaticDimension;
    _detailTableView.estimatedRowHeight = 100.0;
    _detailTableView.backgroundColor = backGroundColor;
    [_detailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.imageView.mas_bottom);
        make.left.and.right.and.bottom.equalTo(self.view);   
    }];
}
- (void)createPlayer
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, width,  width*(9.0/16.0))];
    self.playerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _playerButton.layer.cornerRadius = 40;
    _playerButton.layer.borderWidth = 5.0;
    _playerButton.layer.borderColor = [UIColor colorWithRed:137/255.0 green:191/255.0 blue:0/255.0 alpha:1.0].CGColor;
    _playerButton.backgroundColor = deepblack;
    _playerButton.alpha = 0.7;
    [_playerButton setTitle:@"Play" forState:UIControlStateNormal];
    [_playerButton addTarget:self action:@selector(playerButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.imageView addSubview:_playerButton];
    _imageView.userInteractionEnabled = YES;
    [self.view addSubview:self.imageView];
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:self.anime_AnimationVideoModel.DetailPic] placeholderImage:[UIImage imageNamed:@"Placehold.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imageView.image = [UIImage setBlurImage:self.imageView.image quality:0.6 blurred:0.1];
    }];
    [self.playerButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@80);
        make.height.equalTo(@80);
        make.centerX.equalTo(self.imageView.mas_centerX);
        make.centerY.equalTo(self.imageView.mas_centerY);
    }];
    
}
- (void)playerButtonClick:(UIButton*)button
{
    [self loadVideo:self.videoSource_AnimationVideoModel.sd];
}
- (void)loadVideo:(NSString*)url
{
    
    if (!self.player) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.player = [[KRVideoPlayerController alloc] initWithFrame:CGRectMake(0,64, width, width*(9.0/16.0))];
        __weak typeof(self)weakSelf = self;
        [self.player setDimissCompleteBlock:^{
            weakSelf.player = nil;
        }];
        [self.player showInWindow];
    }
    self.player.contentURL = [NSURL URLWithString:url];

}

#pragma mark - tabbar动画
- (void)viewWillAppear:(BOOL)animated
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    RootTabController * tabbar =(RootTabController *) window.rootViewController;
    [UIView animateWithDuration:0.5 animations:^{
        tabbar.customTabbarView.alpha = 0.0;
    } completion:^(BOOL finished) {
        tabbar.customTabbarView.hidden = YES;
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    RootTabController * tabbar =(RootTabController *) window.rootViewController;
    
    [UIView animateWithDuration:0.5 animations:^{
        tabbar.customTabbarView.alpha = 1.0;
        tabbar.customTabbarView.hidden = NO;
        if (_player) {
            [_player dismiss];
        }
        
    } completion:^(BOOL finished) {
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    infoAnimationDetailCell *cell = [self.detailTableView dequeueReusableCellWithIdentifier:infoAnimationDetailCellID];
    if (cell == nil) {
        cell= [[NSBundle mainBundle]loadNibNamed:@"infoAnimationDetailCell" owner:nil options:0][0];
    }
    cell.titleLabel.text = self.anime_AnimationVideoModel.Name;
    cell.briefLabel.text = self.anime_AnimationVideoModel.Brief;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end

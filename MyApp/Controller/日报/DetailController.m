//
//  DetailController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "DetailController.h"
#import "UIButton+Custom.h"
#import "UIImage+Blur.h"
#import "UMSocial.h"
#import "commentViewController.h"
#import "CachManager.h"
@interface DetailController ()<UIWebViewDelegate,UIScrollViewDelegate,UMSocialUIDelegate>

@property (nonatomic)UIWebView *detailWebView;
@property (nonatomic)UIImageView *detailImageView;
@property (nonatomic)UILabel *detail_titleLabel;
@property (nonatomic)UIButton *commentsButton;
@property (nonatomic)UIButton *favoriteButton;
@property (nonatomic)UIButton *shareButton;
@property (nonatomic)UIView *buttonView;
@property (nonatomic)UIImage *shareImage;
@property (nonatomic)DetailExtra_DayNewsModel *detailExtra_DayNewsModel;
@property (nonatomic)Long_CommentModel *long_Comments;
@property (nonatomic)Short_CommentModel *short_Comments;
@property (nonatomic)NSMutableArray *longCommentsArray;
@property (nonatomic)NSMutableArray *shortCommentsArray;


@end

@implementation DetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithWhite:1.0 alpha:1.0];
//    [self customNav];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;


    
    [self initUI];
    [self fetchWebData];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
#pragma mark - 友盟
- (void)share
{
    
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"561c7d51e0f55ac520001b94"
                                      shareText:[NSString stringWithFormat:@"我推荐了这篇文章:%@  %@",self.detail_DayNewsModel.title,self.detail_DayNewsModel.share_url]
                                     shareImage:_shareImage
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToDouban,UMShareToRenren,nil]
                                       delegate:self];
 
}

#pragma mark - UI
- (void)initUI
{
   
//    self.navigationController.navigationBarHidden = YES;
    self.detailImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _detailImageView.backgroundColor = backGroundColor;
    _detailImageView.userInteractionEnabled = YES;
    [self.view addSubview:_detailImageView];
    //调整图片显示
    _detailImageView.contentMode = UIViewContentModeScaleAspectFill;
    _detailImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _detailImageView.clipsToBounds  = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(detailImageViewTap:)];
    [_detailImageView addGestureRecognizer:tap];
    [_detailImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.equalTo(@200);
        
    }];
    
    _detail_titleLabel = [[UILabel alloc]initWithFrame:CGRectZero];
    _detail_titleLabel.backgroundColor = [UIColor clearColor];
    _detail_titleLabel.textColor = [UIColor whiteColor];
    _detail_titleLabel.textAlignment = NSTextAlignmentLeft;
    _detail_titleLabel.numberOfLines = 0;
    [_detail_titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:24]];
    [_detailImageView addSubview:_detail_titleLabel];
    [_detail_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_detailImageView.mas_left).offset(10);
        make.bottom.equalTo(_detailImageView.mas_bottom).offset(-10);
        make.right.equalTo(_detailImageView.mas_right).offset(-100);
    }];
    
    _buttonView = [[UIView alloc]init];
    _buttonView.backgroundColor = deepblack;
    [self.view addSubview:_buttonView];
    _shareButton = [UIButton setfunctionButtonWithTitle:@"分享" height:40 image:nil selectImage:nil target:self action:@selector(shareButtonClick:)];
    _favoriteButton = [UIButton setfunctionButtonWithTitle:@"收藏" height:40 image:nil selectImage:nil target:self action:@selector(favoriteButtonClick:)];
    _commentsButton = [UIButton setfunctionButtonWithTitle:@"评论" height:40 image:nil selectImage:nil target:self action:@selector(commentsButtonClick:)];

    [_buttonView addSubview:_shareButton];
    [_buttonView addSubview:_commentsButton];
    [_buttonView addSubview:_favoriteButton];
    [_buttonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom).offset(40);
        make.height.equalTo(@40);
    }];
    [_shareButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_buttonView.mas_centerX).offset(-115);
        make.centerY.equalTo(_buttonView.mas_centerY);
    }];
    [_favoriteButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_buttonView.mas_centerX).offset(-5);
        make.centerY.equalTo(_buttonView.mas_centerY);
    }];
    [_commentsButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_buttonView.mas_centerX).offset(105);
        make.centerY.equalTo(_buttonView.mas_centerY);
    }];
    
    self.detailWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_detailWebView];
    _detailWebView.backgroundColor = [UIColor clearColor];
    _detailWebView.opaque = NO;//干掉大黑块
    _detailWebView.delegate =self;
    _detailWebView.scrollView.bounces = NO;
    _detailWebView.scrollView.showsVerticalScrollIndicator = NO;
    _detailWebView.scrollView.delegate = self;
    
//    if (self.detail_DayNewsModel.image == nil) {
        [_detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view.mas_top).offset(200);
            make.bottom.equalTo(_buttonView.mas_top);
            make.left.equalTo(self.view.mas_left).offset(10);
            make.right.equalTo(self.view.mas_right).offset(-10);
        }];
//    }else{
//        [_detailWebView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(self.view.mas_top);
//            make.bottom.equalTo(_buttonView.mas_top);
//            make.left.equalTo(self.view.mas_left).offset(10);
//            make.right.equalTo(self.view.mas_right).offset(-10);
//        }];
//
//    }
        [self favoriteYesOrNo];
    
}
- (void)favoriteYesOrNo
{
    
    if ([[SQLManager shareInstance]fetchById:[NSString stringWithFormat:@"%@",self.detail_DayNewsModel.id]]!=nil) {
        _favoriteButton.userInteractionEnabled = NO;
        [_favoriteButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_favoriteButton setTitle:@"已收藏" forState:UIControlStateNormal];
    }
}
- (void)detailImageViewTap:(UITapGestureRecognizer*)tap
{
    [UIView animateWithDuration:2.0 animations:^{
        
    }];
    
}

#pragma mark- 按钮点击事件
- (void)shareButtonClick:(UIButton*)button
{
    [self share];
}
- (void)commentsButtonClick:(UIButton*)button
{
    
    commentViewController *controller = [[commentViewController alloc]init];
    controller.short_Comments = _short_Comments;
    controller.long_Comments = _long_Comments;
   
    [self.navigationController pushViewController:controller animated:YES];
}
- (void)favoriteButtonClick:(UIButton*)button
{
    [[SQLManager shareInstance]add:[self currentDetail_DayNews]];
    button.userInteractionEnabled = NO;
    [button setTitle:@"已收藏" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
}
- (Detail_DayNewsModel *)currentDetail_DayNews
{
    Detail_DayNewsModel *detail_DayNew = [[Detail_DayNewsModel alloc]init];
    detail_DayNew.id = _detail_DayNewsModel.id;
    detail_DayNew.title = _detail_DayNewsModel.title;
    detail_DayNew.body = _detail_DayNewsModel.body;
    detail_DayNew.image = _detail_DayNewsModel.image;
    detail_DayNew.css = _detail_DayNewsModel.css;
    detail_DayNew.share_url = _detail_DayNewsModel.share_url;
    return detail_DayNew;
}
#pragma mark - 各种代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    int offsetY = _detailWebView.scrollView.contentOffset.y;
    if (offsetY<=_detailImageView.frame.size.height) {
//        self.navigationController.navigationBarHidden = YES;
        _detailImageView.alpha = (1-offsetY/200.0);
//        if (self.detailImageView.hidden == NO) {
            [_detailImageView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(-offsetY);
            }];
//        }
      
        [_buttonView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom).offset(40);
            make.height.equalTo(@40);
        }];
        if (_detailImageView.hidden == NO) {
            [_detailWebView  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top).offset(200-offsetY);
            }];
        }else{
            [_detailWebView  mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
        }
     
    }else{
        self.navigationController.navigationBarHidden = NO;

    }
    if (offsetY >= _detailImageView.frame.size.height) {
        [_buttonView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.equalTo(@40);
        }];    }

}



- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
}
//在浏览器里打开链接
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    if ( navigationType == UIWebViewNavigationTypeLinkClicked ) {
        [[UIApplication sharedApplication] openURL:[request URL]];
        return NO;
    }
    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
//     [webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].style.background='#2E2E2E'"];
    //我不懂，但是我知道是调整webView里面的图片的,呵呵呵呵
    [webView stringByEvaluatingJavaScriptFromString:
          @"var script = document.createElement('script');"
          "script.type = 'text/javascript';"
          "script.text = \"function ResizeImages() { "
          "var myimg,oldwidth;"
          "var maxwidth = 300.0;" // UIWebView中显示的图片宽度
          "for(i=0;i <document.images.length;i++){"
          "myimg = document.images[i];"
          "if(myimg.width > maxwidth){"
          "oldwidth = myimg.width;"
          "myimg.width = maxwidth;"
          "}"
          "}"
          "}\";"
          "document.getElementsByTagName('head')[0].appendChild(script);"];
    [webView stringByEvaluatingJavaScriptFromString:@"ResizeImages();"];
}

#pragma mark - 数据处理
- (void)loadString:(NSString*)str
{
    NSString *url = @"http://news.at.zhihu.com/css/news_qa.auto.css?v=77778";
    [self.detailWebView loadHTMLString:str baseURL:[NSURL URLWithString:url]];
}

- (void)fetchWebData
{
    if (self.ID == NULL) {
        self.ID = _detail_DayNewsModel.id;
    }
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:[NSString stringWithFormat:kDetailUrl,self.ID] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.detail_DayNewsModel = [[Detail_DayNewsModel alloc]initWithData:responseObject error:nil];
        [self.dataDetailArray removeAllObjects];
        [self.dataDetailArray addObject:self.detail_DayNewsModel];
        [self loadString:self.detail_DayNewsModel.body];
        if (self.detail_DayNewsModel.image == nil) {
            self.detailImageView.hidden = YES;
            [self.detailWebView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.view.mas_top);
            }];
        }else{
            [_detailImageView sd_setImageWithURL:[NSURL URLWithString:self.detail_DayNewsModel.image]placeholderImage:[UIImage imageNamed:@"Placehold.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            _shareImage = _detailImageView.image;
            _detailImageView.image = [UIImage setBlurImage:_detailImageView.image quality:1.0f blurred:.6f];
            }];
        }
        _detail_titleLabel.text = self.detail_DayNewsModel.title;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
   
    //长评
    AFHTTPRequestOperationManager *longCommentsManager = [AFHTTPRequestOperationManager manager];
    longCommentsManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:kLongCommentsUrl,self.detail_DayNewsModel.id];
    [longCommentsManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.long_Comments = [[Long_CommentModel alloc]initWithData:responseObject error:nil];

        [self.longCommentsArray addObjectsFromArray:self.long_Comments.comments];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
    AFHTTPRequestOperationManager *shortCommentsManager = [AFHTTPRequestOperationManager manager];
    shortCommentsManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [shortCommentsManager GET:[NSString stringWithFormat:kShortCommentsUrl,self.detail_DayNewsModel.id] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.short_Comments = [[Short_CommentModel alloc]initWithData:responseObject error:nil];
        [self.shortCommentsArray addObjectsFromArray:_short_Comments.comments];
    }failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];

    
}
- (UIWebView*)detailWebView
{
    if (!_detailWebView) {
        _detailWebView = [[UIWebView alloc]initWithFrame:CGRectZero];
        _detailWebView.dataDetectorTypes = UIDataDetectorTypeAll;
    }
    return _detailWebView;
}
- (NSMutableArray*)dataDetailArray
{
    if (!_dataDetailArray) {
        _dataDetailArray = [NSMutableArray array];
    }
    return _dataDetailArray;
}
- (NSMutableArray*)dataDetailExtraArray
{
    if (!_dataDetailExtraArray) {
        _dataDetailExtraArray = [NSMutableArray array];
        
    }
    return _dataDetailExtraArray;
}
- (NSMutableArray*)longCommentArray
{
    if (!_longCommentsArray) {
        _longCommentsArray = [NSMutableArray array];
        
    }
    return _longCommentsArray;
}
- (NSMutableArray*)shortCommentsArray
{
    if (!_shortCommentsArray) {
        _shortCommentsArray = [NSMutableArray array];
        
    }
    return _shortCommentsArray;
}
#pragma mark - 定时器
//{
//
//}
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
        
    } completion:^(BOOL finished) {
        
    }];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end


//
//  guoController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "index_AnimationVideoController.h"
#import "AnimationCell.h"
#import "detailPage_AnimationVideoController.h"
#import "URL.h"
#import "helper.h"
@interface index_AnimationVideoController ()
<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic)UIScrollView *indexScrollView;
@property (nonatomic)UITableView *indexTableView;
@property (nonatomic)UIView *scrollAnchorView;
@property (nonatomic)UIProgressView *progressView;
@property (nonatomic)int page;
@property (nonatomic)NSTimer *timer;

@property (nonatomic)NSMutableArray *dataCellArray;
@property (nonatomic,retain)NSMutableArray *dataScrollArray;

@end

@implementation index_AnimationVideoController

- (void)viewDidLoad {
    [super viewDidLoad];
        self.view.backgroundColor = [UIColor whiteColor];

}
- (void)initUI
{
    [super initUI];
    [self createTimer];
    
    self.navigationController.navigationBar.translucent = NO;
    
    //tabbleView
    self.indexTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _indexTableView.delegate = self;
    _indexTableView.dataSource = self;
    [self.view addSubview:_indexTableView];
    [_indexTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top);
        make.bottom.equalTo(self.view.mas_bottomMargin);
    }];
    [self.indexTableView registerNib:[UINib nibWithNibName:@"AnimationCell" bundle:nil] forCellReuseIdentifier:kanimationCellID];
    self.indexTableView.backgroundColor = backGroundColor;
    _indexTableView.rowHeight = UITableViewAutomaticDimension;
    _indexTableView.estimatedRowHeight = 120;
    
    
    
    
    UIView *headerview = [[UIView alloc] initWithFrame:CGRectMake(0,0, 0,200)];
    self.indexTableView.tableHeaderView = headerview;
    self.indexTableView.separatorColor = backGroundColor;
    
    
    //scrollView-------------------------------------------------------------------
    _scrollAnchorView = [[UIView alloc]init];
    //    _scrollAnchorView.backgroundColor = [UIColor redColor];//参照视图
    _scrollAnchorView.userInteractionEnabled = YES;
    [self.indexTableView.tableHeaderView addSubview:_scrollAnchorView];
    [_scrollAnchorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.indexTableView.tableHeaderView.mas_left);
        make.right.equalTo(self.indexTableView.tableHeaderView.mas_right);
        make.top.equalTo(self.indexTableView.tableHeaderView.mas_top);
        //        make.bottom.equalTo(self.indexTableView.tableHeaderView.mas_bottom);
        make.height.equalTo(@197);
    }];
    
    self.indexScrollView = [[UIScrollView alloc]init];
    _indexScrollView.delegate = self;
    
    _progressView = [[UIProgressView alloc]init];
    _progressView.progress = 0.25;
    _progressView.tintColor = [UIColor grayColor];
    [_indexTableView.tableHeaderView addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_indexTableView.tableHeaderView.mas_left);
        make.right.equalTo(_indexTableView.tableHeaderView.mas_right);
        make.bottom.equalTo(_indexTableView.tableHeaderView.mas_bottom);
        make.height.equalTo(@3);
    }];
    
    
    _indexScrollView.contentSize = CGSizeMake(4*self.view.bounds.size.width,197);
    _indexScrollView.pagingEnabled = YES;
    _indexScrollView.showsVerticalScrollIndicator = NO;
    _indexScrollView.showsHorizontalScrollIndicator = NO;
    _indexScrollView.bounces = NO;
    [self.indexTableView.tableHeaderView addSubview:_indexScrollView];
    [_indexScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.indexTableView.tableHeaderView.mas_left);
        make.right.equalTo(self.indexTableView.tableHeaderView.mas_right);
        make.top.equalTo(self.indexTableView.tableHeaderView.mas_top);
        make.height.equalTo(@197);
    }];
    for (NSInteger i =0 ; i<4; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 1300+i;
        imageView.userInteractionEnabled =YES;
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        imageView.clipsToBounds  = YES;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewTap:)];
        [imageView addGestureRecognizer:tap];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectZero];
        label.center = imageView.center;
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont boldSystemFontOfSize:18];
        label.numberOfLines = 0;
        label.tag = 100+imageView.tag;
        [imageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@300);
            make.height.equalTo(@100);
            make.centerX.equalTo(imageView.mas_centerX);
            make.centerY.equalTo(imageView.mas_centerY).offset(60);
        }];
        
        [_indexScrollView addSubview:imageView];
        if (i==0) {
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(_scrollAnchorView.mas_width);
                make.height.equalTo(_scrollAnchorView.mas_height);
                make.left.equalTo(_indexScrollView.mas_left);
                make.top.equalTo(_indexScrollView.mas_top);
            }];
        }else{
            UIImageView *oldimageView = (UIImageView*)[_indexScrollView viewWithTag:imageView.tag-1];
            [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.width.equalTo(_scrollAnchorView.mas_width);
                make.height.equalTo(_scrollAnchorView.mas_height);
                make.left.equalTo(oldimageView.mas_right);
                make.top.equalTo(_indexScrollView.mas_top);
            }];
        }
    }
    [self JHRefresh];
}
- (void)createTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:3.0 target:self selector:@selector(starttimer:) userInfo:nil repeats:YES];
}
- (void)starttimer:(NSTimer*)timer
{
    CGPoint contentOffset = _indexScrollView.contentOffset;
    contentOffset.x += _indexTableView.tableHeaderView.frame.size.width;
    if (contentOffset.x == _indexTableView.tableHeaderView.frame.size.width *4) {
        contentOffset.x = 0;
        _progressView.progress = 0.25;
    }
    [_indexScrollView setContentOffset:contentOffset animated:YES];
    
}

- (void)JHRefresh
{
    __weak index_AnimationVideoController *weakSelf = self;
    //下拉刷新
    [self.indexTableView addRefreshHeaderViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchWebData];
        
        //结束动画
        [weakSelf.indexTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }];
    
    
    //上拉加载
    [self.indexTableView addRefreshFooterViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetchOldWebData];
        
        [weakSelf.indexTableView footerEndRefreshing];
    }];
    
}
- (void)fetchData
{
    [super fetchData];
}
#pragma mark - 轮播图点击事件
- (void)imageViewTap:(UITapGestureRecognizer*)tap
{
    if (self.dataScrollArray == nil) {
        NSLog(@"没数据，正在加载");
    }else{
        detailPage_AnimationVideoController *controller = [[detailPage_AnimationVideoController alloc]init];
        Anime_AnimationVideoModel *model = self.dataScrollArray[tap.view.tag-1300];
        controller.anime_AnimationVideoModel = model;
        [self.navigationController pushViewController:controller animated:YES];
    }
}

#pragma mark - 刷新数据
- (void)fetchWebData
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];//原始数据输出
    
    [manager GET:kVideoIndexUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _animationVideoModel = [[AnimationVideoModel alloc]initWithData:responseObject error:nil];
        [self.dataCellArray removeAllObjects];
        [self.dataCellArray addObjectsFromArray:_animationVideoModel.data.list.anime];
        
        [self.dataScrollArray removeAllObjects];
        [self.dataScrollArray addObjectsFromArray:_animationVideoModel.data.list.recommend];
        
        for (NSInteger i =0; i<_dataScrollArray.count; i++) {
            _recommend_AnimationVideoModel = _dataScrollArray[i];
            UIImageView *imageView = (UIImageView*)[self.indexTableView.tableHeaderView viewWithTag:1300+i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_recommend_AnimationVideoModel.DetailPic] placeholderImage:[UIImage imageNamed:@"placehold.png"]];
//            UILabel *label = (UILabel*)[imageView viewWithTag:imageView.tag+100];
//            label.text = _anime_AnimationVideoModel.Brief;
        }

        
        [self.indexTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"获取失败");
    }];
}
#pragma mark - 加载数据
- (void)fetchOldWebData
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSString *url = [NSString stringWithFormat:kVideoRandomTenIndexOldUrl];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _animationVideoModel = [[AnimationVideoModel alloc]initWithData:responseObject error:nil];
        [self.dataCellArray addObjectsFromArray:_animationVideoModel.data.list.anime];
        NSLog(@"%ld",self.dataCellArray.count);
        [self.indexTableView reloadData];
        _page = _page+1;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffset = scrollView.contentOffset.x;
    _progressView.progress = contentOffset/_indexScrollView.contentSize.width + 0.25;
}
//
//- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//  
//}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataCellArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AnimationCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kanimationCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Anime_AnimationVideoModel *model = self.dataCellArray[indexPath.row];
    [cell refreshAnimationUIwithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    detailPage_AnimationVideoController *controller = [[detailPage_AnimationVideoController alloc]init];
    Anime_AnimationVideoModel *model = self.dataCellArray[indexPath.row];
    controller.anime_AnimationVideoModel = model;

    
    [self.navigationController pushViewController:controller animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataCellArray{
    if (_dataCellArray==nil) {
        _dataCellArray=[[NSMutableArray alloc]init];
    }
    return _dataCellArray;
}
-(NSMutableArray *)dataScrollArray{
    if (_dataScrollArray==nil) {
        _dataScrollArray=[[NSMutableArray alloc]init];
    }
    return _dataScrollArray;
}

@end

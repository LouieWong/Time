//
//  zhiController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "todayNewsController.h"
#import "NewsCell.h"
#import "DayNewsModel.h"
#import "DetailController.h"
#import "JHRefresh.h"
#import "CustomViewAniView.h"
@interface todayNewsController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>

@property (nonatomic)UIScrollView *indexScrollView;
@property (nonatomic)UITableView *indexTableView;
@property (nonatomic)UIView *scrollAnchorView;
@property (nonatomic)UIProgressView *progressView;

@property (nonatomic)NSTimer *timer;

@property (nonatomic)NSMutableArray *dataCellArray;
@property (nonatomic)NSMutableArray *dataScrollArray;

@property (nonatomic)DayNewsModel *dayNewsModel;
@property (nonatomic)Stories_DayNewsModel *stories_DayNewsModel;
@property (nonatomic)TopStories_DayNewsModel *topStories_DayNewsModel;



@end

@implementation todayNewsController

- (void)layoutSubviews{

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = backGroundColor;

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:nil];
    self.navigationItem.backBarButtonItem = item;
//    [self fetchData];

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
        make.bottom.equalTo(self.view.mas_bottom).offset(-49);
    }];
    [self.indexTableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:kdayPaperCellID];
    self.indexTableView.backgroundColor = backGroundColor;
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
    
    

    _indexScrollView.contentSize = CGSizeMake(5*self.view.bounds.size.width,197);
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
    for (NSInteger i =0 ; i<5; i++) {
        
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.tag = 300+i;
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
        label.tag = 400+i;
        [imageView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.equalTo(@300);
            make.height.equalTo(@60);
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

        
        _progressView = [[UIProgressView alloc]init];
        _progressView.progress = 0.2;
        _progressView.tintColor = [UIColor grayColor];
        [_indexTableView.tableHeaderView addSubview:_progressView];
        [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_indexTableView.tableHeaderView.mas_left);
            make.right.equalTo(_indexTableView.tableHeaderView.mas_right);
            make.bottom.equalTo(_indexTableView.tableHeaderView.mas_bottom);
            make.height.equalTo(@3);
        }];

        
            }
    [self JHRefresh];
}
- (void)createTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(starttimer:) userInfo:nil repeats:YES];
}
- (void)starttimer:(NSTimer*)timer
{
    CGPoint contentOffset = _indexScrollView.contentOffset;
    contentOffset.x += _indexTableView.tableHeaderView.frame.size.width;
    if (contentOffset.x == _indexTableView.tableHeaderView.frame.size.width *5) {
        contentOffset.x = 0;
        _progressView.progress = 0.2;
    }
    [_indexScrollView setContentOffset:contentOffset animated:YES];
        
}

- (void)JHRefresh
{
    __weak todayNewsController *weakSelf = self;
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
//    if (![self fetchLocalData]) {
////        [self fetchWebData];
//    }
//    [self fetchWData];
}
- (BOOL)fetchLocalData
{
    if ([CachManager isCacheDataInvalid:kIndexUrl]) {
        id respondData = [CachManager readDataAtUrl:kIndexUrl];
        [self parseCacheData:respondData];
        [self.indexTableView reloadData];
        return YES;
    }
    return NO;
}
- (void)parseCacheData:(id)respondData
{
    //解析数据，刷新表
    NSLog(@"%@",respondData);
    self.dataCellArray = (NSMutableArray*)[Stories_DayNewsModel parseRespondData:(NSDictionary*)respondData];
}
#pragma mark - 轮播图点击事件
- (void)imageViewTap:(UITapGestureRecognizer*)tap
{
    DetailController *controller = [[DetailController alloc]init];
    
    Detail_DayNewsModel *detail_DayNewsModel = _dataScrollArray[tap.view.tag-300];
    controller.detail_DayNewsModel = detail_DayNewsModel;
    [self.navigationController pushViewController:controller animated:YES];

}

#pragma mark - 刷新数据
- (void)fetchWebData
{

    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];//原始数据输出
    

    [manager GET:kIndexUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        _dayNewsModel = [[DayNewsModel alloc]initWithData:responseObject error:nil];
//        NSLog(@"%@",responseObject);
        [self.dataCellArray removeAllObjects];
        [self.dataCellArray addObjectsFromArray:_dayNewsModel.stories];
        [self.dataScrollArray removeAllObjects];
        [self.dataScrollArray addObjectsFromArray:_dayNewsModel.top_stories];
        
        for (NSInteger i =0; i<_dataScrollArray.count; i++) {
            _topStories_DayNewsModel = _dataScrollArray[i];
            UIImageView *imageView = (UIImageView*)[self.indexTableView.tableHeaderView viewWithTag:300+i];
            [imageView sd_setImageWithURL:[NSURL URLWithString:_topStories_DayNewsModel.image] placeholderImage:[UIImage imageNamed:@"placehold.png"]];
            UILabel *label = (UILabel*)[imageView viewWithTag:imageView.tag+100];
            label.text = _topStories_DayNewsModel.title;
        }
        [CachManager saveData:responseObject atUrl:[NSString stringWithFormat:kOldIndexUrl,_dayNewsModel.date]];
//        NSLog(@"%@",responseObject);
//        NSLog(@"%ld",[CachManager cacheSize]);

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
    [manager GET:[NSString stringWithFormat:kOldIndexUrl,_dayNewsModel.date] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
                _dayNewsModel = [[DayNewsModel alloc]initWithData:responseObject error:nil];
        [self.dataCellArray addObjectsFromArray:_dayNewsModel.stories];
        NSLog(@"%ld",self.dataCellArray.count);
        [self.indexTableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 代理
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float contentOffset = scrollView.contentOffset.x;
    _progressView.progress = contentOffset/_indexScrollView.contentSize.width + 0.2;
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *date = [super getCurrentTime];
    if ([self.dayNewsModel.date isEqualToString:date]) {
        return [NSString stringWithFormat:@"今日热闻"];
    }else{
        return self.dayNewsModel.date;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataCellArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kdayPaperCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    Stories_DayNewsModel *model = self.dataCellArray[indexPath.row];
    [cell refreshUIwithModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *controller = [[DetailController alloc]init];
    Detail_DayNewsModel *detail_DayNewsModel = self.dataCellArray[indexPath.row];
    controller.detail_DayNewsModel = detail_DayNewsModel;
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

//
//  baseAssortmentController.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "assortmentChildController.h"
#import "JHRefresh.h"
#import "NewsCell.h"
@interface assortmentChildController ()

@end

@implementation assortmentChildController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initUI];
    [self fetWebData];
}
- (void)initUI
{
    self.topImageView = [[UIImageView alloc]initWithFrame:CGRectZero];
    _topImageView.backgroundColor = backGroundColor;
    _topImageView.userInteractionEnabled = YES;
    [self.view addSubview:_topImageView];
    //调整图片显示
    _topImageView.contentMode = UIViewContentModeScaleAspectFill;
    _topImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _topImageView.clipsToBounds  = YES;

    
    [_topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
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
    [_detail_titleLabel setFont:[UIFont fontWithName:@"TrebuchetMS-Bold" size:20]];
    [_topImageView addSubview:_detail_titleLabel];
    [_detail_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_topImageView.mas_left).offset(10);
        make.bottom.equalTo(_topImageView.mas_bottom).offset(-10);
        make.right.equalTo(_topImageView.mas_right).offset(-100);
        make.height.equalTo(@80);
    }];
    self.indexTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _indexTableView.delegate = self;
    _indexTableView.dataSource = self;
    [self.view addSubview:_indexTableView];
    [_indexTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.topImageView.mas_bottom);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    [self.indexTableView registerNib:[UINib nibWithNibName:@"NewsCell" bundle:nil] forCellReuseIdentifier:kdayPaperCellID];
    self.indexTableView.backgroundColor = backGroundColor;
    _indexTableView.estimatedRowHeight = 120;
    [self JHRefresh];
    
}


- (void)JHRefresh
{
    __weak assortmentChildController *weakSelf = self;
    //下拉刷新
    [self.indexTableView addRefreshHeaderViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetWebData];
        
        //结束动画
        [weakSelf.indexTableView headerEndRefreshingWithResult:JHRefreshResultSuccess];
    }];
    
    
    //上拉加载
    [self.indexTableView addRefreshFooterViewWithAniViewClass:[CustomViewAniView class] beginRefresh:^{
        
        [weakSelf fetOldWebData];
        
        [weakSelf.indexTableView footerEndRefreshing];
    }];
    
}

#pragma mark -获取数据
- (void)fetWebData
{
    
}
- (void)fetOldWebData
{
 

}

- (void)fetDatawithUrl:(NSString*)url
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        self.assortmentModel = [[AssortmentModel alloc]initWithData:responseObject error:nil];
        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_assortmentModel.image]];
//        self.detail_titleLabel.text = _assortmentModel.description;
        [self.dataArray removeAllObjects];
        [self.dataArray addObjectsFromArray:_assortmentModel.stories];
        [self.indexTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
//    AFHTTPRequestOperationManager *assArrayManager = [[AFHTTPRequestOperationManager alloc]init];
//    assArrayManager.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [assArrayManager GET:@"http://news-at.zhihu.com/api/4/themes" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        self.assortmentArrayModel = [[AssortmentArrayModel alloc]initWithData:responseObject error:nil];
//        [self.assDataArray addObjectsFromArray:_assortmentArrayModel.others];
//        NSLog(@"%@",self.assDataArray);
//        [self.themeID removeAllObjects];
//        [self.themeTitle removeAllObjects];
//        for (NSInteger i=0; i<self.assDataArray.count; i++) {
//            AssortmentArrayOtherModel *model = self.assDataArray[i];
////            NSLog(@"%@",model);
//            [self.themeID addObject:model.id];
//            [self.themeTitle addObject:model.name];
//        }
//        NSLog(@"%@",self.themeID);
//        NSLog(@"%@",self.themeTitle);
//
//        
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        
//    }];
//
}
- (void)fetOldDatawithUrl:(NSString*)url
{
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc]init];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",url);
        self.assortmentModel = [[AssortmentModel alloc]initWithData:responseObject error:nil];
//        [self.topImageView sd_setImageWithURL:[NSURL URLWithString:_assortmentModel.image]];
        //        self.detail_titleLabel.text = _assortmentModel.description;
        [self.dataArray addObjectsFromArray:_assortmentModel.stories];
        [self.indexTableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}
#pragma mark - 各种代理

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NewsCell *cell = [_indexTableView dequeueReusableCellWithIdentifier:kdayPaperCellID];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    StoriesModel *model = self.dataArray[indexPath.row];
    [cell refreshAssortmentUIwithModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *controller = [[DetailController alloc]init];
    StoriesModel *model = self.dataArray[indexPath.row];
    controller.ID = model.id;
    [self.navigationController pushViewController:controller animated:YES];


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)dataArray{
    if (_dataArray==nil) {
        _dataArray=[[NSMutableArray alloc]init];
    }
    return _dataArray;
}
-(NSMutableArray *)assDataArray{
    if (_assDataArray==nil) {
        _assDataArray=[[NSMutableArray alloc]init];
    }
    return _assDataArray;
}
-(NSMutableArray *)themeID{
    if (_themeID==nil) {
        _themeID=[[NSMutableArray alloc]init];
    }
    return _themeID;
}
-(NSMutableArray *)themeTitle{
    if (_themeTitle==nil) {
        _themeTitle=[[NSMutableArray alloc]init];
    }
    return _themeTitle;
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
    } completion:^(BOOL finished) {
    }];
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

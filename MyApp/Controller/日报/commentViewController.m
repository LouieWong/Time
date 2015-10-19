//
//  commentViewController.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/13.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "commentViewController.h"
#import "AnimationVideoModel.h"
#import "Masonry.h"
#import "RootTabController.h"
#import "CommentCell.h"
@interface commentViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic) UITableView *commentTableView;


@end

@implementation commentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = deepblack;
    [self initData];
    
    
}
- (void)initData
{
    [self.shortCommentsArray removeAllObjects];
    [self.shortCommentsArray addObjectsFromArray:_short_Comments.comments];
    [self.shortCommentsArray addObjectsFromArray:_long_Comments.comments];
    [self initUI];
}
- (void)initUI
{
    self.commentTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _commentTableView.delegate =self;
    _commentTableView.dataSource = self;
    _commentTableView.estimatedRowHeight = 44;
    _commentTableView.rowHeight =UITableViewAutomaticDimension;
    [self.view addSubview:_commentTableView];
    
    [_commentTableView registerNib:[UINib nibWithNibName:@"CommentCell" bundle:nil]  forCellReuseIdentifier:kCommentCellID];
    [_commentTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.top.equalTo(self.view.mas_top).offset(-40);
        make.bottom.equalTo(self.view.mas_bottom).offset(49);
    }];
}
//隐藏状态栏
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    return;
//}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.shortCommentsArray.count;
    
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentCell *cell = [_commentTableView dequeueReusableCellWithIdentifier:kCommentCellID];
    CommentsModel *model = self.shortCommentsArray[indexPath.row];

    [cell refreshCommentsUIwithModel:model];
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSMutableArray *)shortCommentsArray
{
    if (_shortCommentsArray==nil) {
        _shortCommentsArray=[[NSMutableArray alloc]init];
    }
    return _shortCommentsArray;
}

#pragma mark - tabbar动画
- (void)viewWillAppear:(BOOL)animated
{
    UIWindow * window = [UIApplication sharedApplication].keyWindow;
    
    RootTabController * tabbar =(RootTabController *) window.rootViewController;
    tabbar.customTabbarView.alpha = 0.0;
}
@end

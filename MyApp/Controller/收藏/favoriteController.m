//
//  favoriteController.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "favoriteController.h"
#import "FavoriteCell.h"
#import "SQLManager.h"
#import "DetailController.h"
@interface favoriteController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)UITableView *favoriteTable;
@property (nonatomic)NSMutableArray *dataArray;

@end

@implementation favoriteController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = backGroundColor;
    NSMutableArray *arr = [[SQLManager shareInstance]fetchAll];
    self.dataArray = arr;
    [self.favoriteTable reloadData];
}
- (void)initUI
{
    [super initUI];
    self.navigationController.navigationBar.translucent = NO;
    _favoriteTable = [[UITableView alloc]init];
    _favoriteTable.delegate = self;
    _favoriteTable.dataSource = self;
    [self.view addSubview:_favoriteTable];
    _favoriteTable.backgroundColor = backGroundColor;
    _favoriteTable.estimatedRowHeight = 44;
    _favoriteTable.rowHeight =UITableViewAutomaticDimension;

    [_favoriteTable registerNib:[UINib nibWithNibName:@"FavoriteCell" bundle:nil] forCellReuseIdentifier:kFavoriteCellID];
    [_favoriteTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(5);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavoriteCell *cell = [_favoriteTable dequeueReusableCellWithIdentifier:kFavoriteCellID];
    Detail_DayNewsModel *model = self.dataArray[indexPath.row];
    [cell.favoriteImageView sd_setImageWithURL:[NSURL URLWithString:model.image]];
    cell.titileLabel.text = model.title;
    cell.backgroundColor = backGroundColor;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DetailController *controller = [[DetailController alloc]init];
    controller.detail_DayNewsModel = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}
- (NSMutableArray*)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
        
    }
    return _dataArray;
}
@end
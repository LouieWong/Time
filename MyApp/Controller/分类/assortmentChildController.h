//
//  baseAssortmentController.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "helper.h"
#import "Masonry.h"
#import "AFNetworking.h"
#import "AssortmentModel.h"
#import "UIImage+Blur.h"
#import "UIImageView+WebCache.h"
#import "URL.h"
#import "DetailController.h"
@interface assortmentChildController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic)UIImageView *topImageView;
@property (nonatomic)UILabel *detail_titleLabel;
@property (nonatomic)UITableView *indexTableView;
@property (nonatomic)AssortmentModel *assortmentModel;
@property (nonatomic)AssortmentArrayModel *assortmentArrayModel;
@property (nonatomic)AssortmentArrayOtherModel *assortmentArrayOtherModel;
@property (nonatomic)NSMutableArray *dataArray;
@property (nonatomic)NSMutableArray *assDataArray;
@property (nonatomic)NSMutableArray *themeID;
@property (nonatomic)NSMutableArray *themeTitle;
@property (nonatomic)NSNumber *ID;

- (void)initUI;
- (void)fetOldWebData;
- (void)fetOldDatawithUrl:(NSString*)url;
- (void)fetWebData;
- (void)fetDatawithUrl:(NSString*)url;

@end

//
//  DetailController.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
#import "helper.h"
#import "URl.h"
#import "RootTabController.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "UIImageView+WebCache.h"
#import "DayNewsModel.h"
#import "SQLManager.h"
@interface DetailController : UIViewController


@property (nonatomic) NSMutableArray *dataDetailArray;
@property (nonatomic) NSMutableArray *dataDetailExtraArray;
@property (nonatomic) Stories_DayNewsModel *stories_DayNewsModel;
@property (nonatomic) Detail_DayNewsModel *detail_DayNewsModel;
@property (nonatomic) NSNumber *ID;

@end

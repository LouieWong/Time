//
//  zhiController.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "BaseController.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "JSONModel.h"
#import "DayNewsModel.h"
#import "DetailController.h"
#import "JHRefresh.h"
#import "CustomViewAniView.h"
@interface todayNewsController : BaseController

@property(nonatomic)AFHTTPRequestOperationManager *manager;

@end

//
//  guoController.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/3.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "BaseController.h"
#import "AFNetworking.h"
#import "SDImageCache.h"
#import "DetailController.h"
#import "JHRefresh.h"
#import "CustomViewAniView.h"
#import "AnimationVideoModel.h"


@interface index_AnimationVideoController : BaseController

@property(nonatomic)AFHTTPRequestOperationManager *manager;
@property (nonatomic)AnimationVideoModel *animationVideoModel;
@property (nonatomic)Anime_AnimationVideoModel *anime_AnimationVideoModel;
@property (nonatomic)Data_AnimationVideoModel *data_AnimationVideoModel;
@property (nonatomic)List_AnimationVideoModel *list_AnimationVideoModel;
@property (nonatomic)Recommend_AnimationVideoModel *recommend_AnimationVideoModel;
@property (nonatomic)VideoSource_AnimationVideoModel *VideoSource_AnimationVideoModel;
@property (nonatomic)Category_AnimationVideoModel *category_AnimationVideoModel;


@end

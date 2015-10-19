//
//  AnimationCell.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/12.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationVideoModel.h"
#import "UIImageView+WebCache.h"
#define kanimationCellID @"animationCellID"
@interface AnimationCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@property (nonatomic)Anime_AnimationVideoModel *anime_AnimationVideoModelCellModel;
- (void)refreshAnimationUIwithModel:(Anime_AnimationVideoModel*)model;
@end

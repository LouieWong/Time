//
//  infoAnimationDetailCell.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/21.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationVideoModel.h"
static NSString *infoAnimationDetailCellID = @"infoAnimationDetailCellID";
@interface infoAnimationDetailCell : UITableViewCell
@property (nonatomic) IBOutlet UIView *BriefView;
@property (nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic) IBOutlet UILabel *colorlabel;
@property (nonatomic) IBOutlet UILabel *briefLabel;
@property (nonatomic) Anime_AnimationVideoModel *anime_AnimationVideoModel;
@end

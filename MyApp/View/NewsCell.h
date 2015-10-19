//
//  NewsCell.h
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayNewsModel.h"
#import "UIImageView+WebCache.h"
#import "assortmentModel.h"
#define kdayPaperCellID @"dayPaPerCellID"
@interface NewsCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UIView *backView;

@property (nonatomic)Stories_DayNewsModel *appIndexCellModel;
- (void)refreshUIwithModel:(Stories_DayNewsModel*)model;
- (void)refreshAssortmentUIwithModel:(StoriesModel*)model;
@end

//
//  FavoriteCell.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayNewsModel.h"
#import "UIImageView+WebCache.h"
#define kFavoriteCellID @"FavoriteCellID"
@interface FavoriteCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *favoriteImageView;
@property (weak, nonatomic) IBOutlet UILabel *titileLabel;

@end

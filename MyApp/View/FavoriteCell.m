//
//  FavoriteCell.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/14.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "FavoriteCell.h"

@implementation FavoriteCell

- (void)awakeFromNib {
    _favoriteImageView.contentMode = UIViewContentModeScaleAspectFill;
    _favoriteImageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    _favoriteImageView.clipsToBounds  = YES;

}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end

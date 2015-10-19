//
//  AnimationCell.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/12.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "AnimationCell.h"
#import "helper.h"

@implementation AnimationCell

- (void)awakeFromNib {
    self.titleImage.layer.cornerRadius=3.0;
    self.titleImage.layer.masksToBounds=YES;
    self.contentView.backgroundColor = backGroundColor;
    self.backgroundColor =backGroundColor;
}
- (void)setModel:(Anime_AnimationVideoModel*)model
{
    if (_anime_AnimationVideoModelCellModel != model) {
        _anime_AnimationVideoModelCellModel = model;
        [self refreshAnimationUIwithModel:model];
    }
}
- (void)refreshAnimationUIwithModel:(Anime_AnimationVideoModel*)model
{
    NSString *url = model.DetailPic;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.titleLabel.text = model.Name;
    self.detailLabel.text = model.Brief;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  infoAnimationDetailCell.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/21.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "infoAnimationDetailCell.h"
#import "helper.h"
#import "Masonry.h"

@implementation infoAnimationDetailCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.backgroundColor = backGroundColor;
}


- (void)addBriefView{
    self.BriefView = [[UIView alloc]init];
    _BriefView.backgroundColor = [UIColor whiteColor];
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.text =  self.anime_AnimationVideoModel.Name;
    _titleLabel.font =  [UIFont boldSystemFontOfSize:24];
    _colorlabel = [[UILabel alloc]init];
    _colorlabel.backgroundColor = lightGray;
    _briefLabel = [[UILabel alloc]init];
    _briefLabel.text = self.anime_AnimationVideoModel.Brief;
    _briefLabel.numberOfLines = 0;
    _briefLabel.font = [UIFont systemFontOfSize:14];
    [self.BriefView addSubview:_titleLabel];
    [self.BriefView addSubview:_colorlabel];
    [self.BriefView addSubview:_briefLabel];
    [self.contentView addSubview:_BriefView];
    [_BriefView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        //        make.bottom.equalTo(self.view.mas_bottom);
        make.height.equalTo(@600);
    }];
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_BriefView.mas_top);
        make.left.equalTo(_BriefView.mas_left).offset(10);
        make.right.equalTo(_BriefView.mas_right).offset(-10);
        make.height.equalTo(@50);
    }];
    [_colorlabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_titleLabel.mas_bottom);
        make.left.equalTo(_titleLabel.mas_left);
        make.right.equalTo(_titleLabel.mas_right);
        make.height.equalTo(@3);
    }];
    [_briefLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_colorlabel.mas_bottom);
        make.left.equalTo(_BriefView.mas_left).offset(10);
        make.right.equalTo(_BriefView.mas_right).offset(-10);
        make.bottom.equalTo(_BriefView.mas_bottom);
    }];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

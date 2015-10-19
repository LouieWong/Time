//
//  NewsCell.m
//  FirstApp
//
//  Created by qianfeng001 on 15/10/4.
//  Copyright (c) 2015年 Louie Wong. All rights reserved.
//

#import "NewsCell.h"
#import "helper.h"
#import "Masonry.h"
@implementation NewsCell

- (void)awakeFromNib {
    self.titleImage.layer.cornerRadius=3.0;
    self.titleImage.layer.masksToBounds=YES;
    self.contentView.backgroundColor = backGroundColor;
    self.backgroundColor =backGroundColor;
}
- (void)setModel:(Stories_DayNewsModel*)model
{
    if (_appIndexCellModel != model) {
        _appIndexCellModel = model;
        [self refreshUIwithModel:model];
    }
}
- (void)refreshUIwithModel:(Stories_DayNewsModel*)model
{
    NSString *url = model.images[0];
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.title.text = model.title;
}
- (void)refreshAssortmentUIwithModel:(StoriesModel*)model
{
    if (model.images ==nil) {
        self.titleImage.hidden = YES;
        [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.backView.mas_right).offset(-8);
        }];
    }else{
        NSString *url = model.images[0];
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:url]];
    }
    self.title.text = model.title;
//    self.titleImage.hidden = NO;
//    [self.title mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.backView.mas_right);
//    }];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

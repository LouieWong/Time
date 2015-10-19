//
//  CommentCell.m
//  MyApp
//
//  Created by qianfeng001 on 15/10/13.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import "CommentCell.h"
#import "helper.h"
@implementation CommentCell

- (void)awakeFromNib {
    self.authorImage.layer.cornerRadius = 25.0;
    self.authorImage.layer.masksToBounds=YES;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor =backGroundColor;
}
- (void)setModel:(CommentsModel*)model
{
    if (_commentsModel != model) {
        _commentsModel = model;
        [self refreshCommentsUIwithModel:model];
    }
}
- (void)refreshCommentsUIwithModel:(CommentsModel*)model
{
    NSString *url = model.avatar;
    [self.authorImage sd_setImageWithURL:[NSURL URLWithString:url]];
    
    self.author.text = model.author;
    self.content.text = model.content;
    self.timer.text = [NSString stringWithFormat:@"%@",model.timer];
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

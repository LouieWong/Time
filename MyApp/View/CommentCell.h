//
//  CommentCell.h
//  MyApp
//
//  Created by qianfeng001 on 15/10/13.
//  Copyright (c) 2015年 王磊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DayNewsModel.h"
#import "UIImageView+WebCache.h"
#define kCommentCellID @"CommentCellID"
@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *authorImage;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UILabel *timer;

@property (nonatomic)CommentsModel *commentsModel;
- (void)setModel:(CommentsModel*)model;
- (void)refreshCommentsUIwithModel:(CommentsModel*)model;
@end
